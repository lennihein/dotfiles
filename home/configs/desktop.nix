{ pkgs, pkgsMaster, ... }:
let
  antigravity-ide-sandboxed = pkgs.symlinkJoin {
    name = "antigravity-ide";
    paths = [ pkgsMaster.antigravity-ide ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/antigravity-ide \
        --add-flags "--no-sandbox"
    '';
  };
in
{
  home.packages = with pkgs; [
    google-chrome
    kitty
    obsidian
    antigravity-ide-sandboxed
  ];
}
