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
    webex
    unsloth-desktop
  ];

  # enable also pulls the package in via programs.vscode.package, so vscode
  # is deliberately absent from home.packages above.
  programs.vscode = {
    enable = true;

    # Default, but load-bearing: the Mistral Vibe extension installs and
    # self-updates through the IDE, so ~/.vscode/extensions/extensions.json
    # has to stay writable instead of being replaced by a generated one.
    mutableExtensionsDir = true;

    # settings.json becomes a real writable file rather than a symlink into
    # the store, so the IDE's settings UI works and keys we don't declare
    # accumulate locally. On every switch the declared set below is merged
    # back over it with jq's `$dynamic * $static`, so edits to a declared key
    # are reverted and comments are lost; keys absent from here are kept.
    profiles.default.mutableUserSettings = true;

    profiles.default.userSettings = {
      # editor
      "editor.fontFamily" = "Google Sans Code, Pragmata Pro, Pragmasevka Nerd Font";
      "editor.fontLigatures" = true;
      "editor.cursorWidth" = 2;
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.inlineSuggest.enabled" = true;
      "editor.minimap.enabled" = true;
      "editor.minimap.renderCharacters" = false;
      "editor.renderWhitespace" = "trailing";
      "editor.wordWrap" = "on";

      # files
      "files.eol" = "\n";
      "workbench.editorAssociations" = {
        "*.md" = "vscode.markdown.editor";
      };

      # workbench
      "workbench.auxiliaryActivityBar.location" = "bottom";
      "workbench.colorTheme" = "Dracula Theme";
      "workbench.startupEditor" = "none";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "extensions.ignoreRecommendations" = true;

      # terminal
      "terminal.integrated.cursorStyle" = "line";
      "terminal.integrated.fontLigatures.enabled" = true;
      "terminal.integrated.tabs.enabled" = false;

      # git
      "git.autofetch" = true;
      "git.confirmSync" = false;

      # telemetry
      "telemetry.telemetryLevel" = "off";
      "telemetry.editStats.enabled" = false;
      "telemetry.feedback.enabled" = false;

      # built-in AI: the Vibe extension is the agent here
      "chat.disableAIFeatures" = true;
      "chat.agent.enabled" = false;
      "chat.titleBar.openInAgentsWindow.enabled" = false;
      "github.copilot.chat.copilotDebugCommand.enabled" = false;
      "github.copilot.chat.tools.viewImage.enabled" = false;

      # misc
      "markdown.preview.fontFamily" = "Google Sans";
      "python.analysis.typeCheckingMode" = "standard";
      "remote.autoForwardPortsSource" = "hybrid";
      "security.promptForLocalFileProtocolHandling" = false;
      "security.workspace.trust.untrustedFiles" = "open";
    };
  };
}
