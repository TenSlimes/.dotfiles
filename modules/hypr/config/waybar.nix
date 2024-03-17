{ inputs, lib, config, pkgs, ... }:
let
  colorPalette = config.colorScheme.palette;
  nixc-lib = inputs.nix-colors.lib-core;

  convertToRGB = color:
    (builtins.concatStringsSep ","
      (builtins.map (x: toString x) (nixc-lib.conversions.hexToRGB color)));
in {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        margin-top = 5;
        margin-right = 3;
        margin-left = 3;
        layer = "top";
        output = "HDMI-A-1";
        position = "top";
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        #modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "tray" ];
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = { "default" = ""; };
        };
        "hyprland/window" = {
          format = " {title}";
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
      * {
        border: none;
        font-family: 'Fira Code', 'Symbols Nerd Font Mono';
        font-size: 16px;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
        min-height: 20px;
      }

      window#waybar {
        background: transparent;
      }

      #workspaces {
        background: rgba(${convertToRGB colorPalette.base00}, 0.5);
        margin-left: 5px;
        border-radius: 10px;
        border: 1px solid #${colorPalette.base07};
        min-height: 17px;
      }

      #workspaces button {
        color: #${colorPalette.base07};
      }

      #workspaces button.active {
        color: #${colorPalette.base0C};
      }
    '';

  };
}
