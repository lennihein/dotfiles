{ pkgs, ... }:
{
  services.ttyd = {
    enable = true;
    interface = "0.0.0.0";
    port = 7681;
    writeable = true;
    entrypoint = [ "${pkgs.shadow}/bin/login" "-f" "lenni" ];
    clientOptions = {
      theme = ''{"background": "#282a36", "foreground": "#f8f8f2", "cursor": "#f8f8f2", "selectionBackground": "#44475a", "black": "#21222c", "red": "#ff5555", "green": "#50fa7b", "yellow": "#f1fa8c", "blue": "#bd93f9", "magenta": "#ff79c6", "cyan": "#8be9fd", "white": "#bfbfbf", "brightBlack": "#6272a4", "brightRed": "#ff6e6e", "brightGreen": "#69ff94", "brightYellow": "#ffffa5", "brightBlue": "#d6acff", "brightMagenta": "#ff92df", "brightCyan": "#a4ffff", "brightWhite": "#ffffff"}'';
    };
  };
}
