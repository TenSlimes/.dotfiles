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
        layer = "top";
        position = "bottom";
        modules-left = [ "custom/nixos" "hyprland/workspaces" ];
        "custom/nixos" = {
          format = "  ";
          tooltip = false;
          #on-click = "";
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          tooltip = false;
          all-outputs = true;
          format-icons = {
            active = "";
            default = "";
          };
        };
      };
    };
    style = ''
      * {
        border: none;
        font-family: 'Fira Code', 'Symbols Nerd Font Mono';
        font-size: 16px;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
        min-height: 35px;
      }

      window#waybar {
        background: transparent;
      }

      #custom-nixos, #workspaces {
        background: #${colorPalette.base00};
        margin-left: 10px;
      }

    '';

  };
}
