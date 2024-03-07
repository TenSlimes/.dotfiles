{ lib, config, pkgs, ... }:
let colorPalette = config.colorScheme.palette;
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        #modules-left = [ "hyprland/window" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "tray" ];
        "hyprland/workspaces" = {
          format = "<sub>{icon}</sub>";
          format-window-separator = " | ";
        };
        "hyprland/window" = {
          format = "{title}";
          rewrite = {

          };
        };
        "tray" = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
    style = ''
      window#waybar {
        padding: 0px 10px;
        background: #${colorPalette.base00};
      }
    '';

  };
}
