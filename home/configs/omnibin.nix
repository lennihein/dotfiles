# Every executable nixpkgs ever shipped, resolved on demand.
#
# Two commands, matching upstream's two binaries:
#
#   omni              session: omnibin-shell, everything on PATH, torn down on exit
#   omni <cmd> ...    one command inside omnibin, no session
#   omnibin which X   ask the index what resolves; --all lists every version.
#                     Costs no downloads.
#
# They are separate names on purpose: `which` is itself an executable omnibin
# can run, so folding the index query into `omni which ...` would be ambiguous.
#
# Plus: any command that isn't installed prompts, then runs through omnibin.
#
# Nothing is installed and the real /nix/store is never overlaid system-wide --
# each invocation runs in a mount namespace that dies with it. Needs network the
# first time a package is used. Versioned forms work too:
# `python3@3.6.2 -c 'print(1)'`.
#
# omnibinCli and omnibinShell are store paths built from the rev in flake.lock
# (see flake.nix), so there is no `nix run` and no flake evaluation per call.
# That rev pins both the binary and the index database -- a fixed-output fetch
# of a dated data release -- so newly nameable commands only appear after
# `nix flake update omnibin`. Package bytes always come from cache.nixos.org.
#
# The mount daemon prints a three-line banner to stdout on every start. It
# shares that stream with the command being run and upstream has no --quiet,
# so shellQuietBin below is the same wrapper with the daemon's stdout
# redirected, used for one-shot runs. The bare session keeps the unpatched
# one, since there the banner is what tells you where the mounts landed.
#
# The `test -x` guard in the handler is load-bearing: if the store path were
# ever unresolvable, fish would report *it* as a missing command and re-enter
# this handler forever. `test` is a builtin, so the guard cannot recurse.
#
# Known limitation: fish sets `status` to 127 after running
# fish_command_not_found regardless of what the handler returns, so
# `cowsay hi && echo ok` takes the failure branch even when cowsay succeeded.
# Output is unaffected; only && / || / if chains see the wrong status.
#
# If omnibin-shell is SIGKILLed it leaves a dead FUSE mount behind and later
# runs fail with "Transport endpoint is not connected". The wrapper tries
# `fusermount3 -u` on both paths before mounting, but that does not recover a
# mount whose daemon is gone, so clear it by hand:
#   fusermount3 -u "$XDG_RUNTIME_DIR/omnibin-store"
{ pkgs, omnibinCli, omnibinShell, ... }:
let
  shell = "${omnibinShell}/bin/omnibin-shell";

  # Upstream's wrapper starts the mount daemon in the background with stdout
  # inherited, and that daemon prints its banner with println! -- same stream
  # as the command we are about to run, no --quiet, no env var, no tty check.
  # Redirecting the daemon's own stdout is the only way to drop it without
  # touching the command's output. --replace-fail means a reworded upstream
  # wrapper fails the build instead of silently bringing the banner back.
  shellQuietBin = pkgs.runCommand "omnibin-shell-quiet" { } ''
    mkdir -p $out/bin
    cp ${omnibinShell}/bin/omnibin-shell $out/bin/omnibin-shell
    chmod +w $out/bin/omnibin-shell
    substituteInPlace $out/bin/omnibin-shell \
      --replace-fail '--cache-dir "$OMNIBIN_CACHE" &' '--cache-dir "$OMNIBIN_CACHE" >/dev/null &'
    chmod +x $out/bin/omnibin-shell
  '';
  shellQuiet = "${shellQuietBin}/bin/omnibin-shell";
in
{
  programs.fish.functions = {
    # omnibin-shell: a user+mount namespace with the lazy store overlaid.
    # Bare = session (banner included), with args = one quiet command.
    omni = ''
      if test (count $argv) -eq 0
          ${shell}
      else
          ${shellQuiet} $argv
      end
    '';

    # The CLI wrapper has OMNIBIN_DB set; the bare binary has no database and
    # so cannot answer `which`.
    omnibin = "${omnibinCli}/bin/omnibin $argv";

    fish_command_not_found = ''
      if not status is-interactive
          __fish_default_command_not_found_handler $argv
      else if not test -x ${shellQuiet}
          __fish_default_command_not_found_handler $argv
      else
          # -P passes the prompt to the reader literally. Without it fish draws
          # its own default prompt -- a green "read> " -- after ours.
          # Enter or y runs it; only an answer starting with n declines. A failed
          # read is EOF or Ctrl-C, which must not fall through to running it.
          if not read -l -P "omnibin: '$argv[1]' is not installed -- fetch and run it? [Y/n] " __omnibin_reply
              __fish_default_command_not_found_handler $argv
          else if string match -q -i 'n*' -- "$__omnibin_reply"
              __fish_default_command_not_found_handler $argv
          else
              ${shellQuiet} $argv
          end
      end
    '';
  };
}
