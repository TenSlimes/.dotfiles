{ lib, inputs, config, pkgs, ... }:
let
  waybar = import ./config/waybar.nix;
  # Some hyprland config
  windowrules = import ./config/windowrules.nix;
  colors = import ./config/colors.nix;
  animations = import ./config/animations.nix;
  keybinds = import ./config/keybindings.nix;
  environment = import ./config/environment.nix;
  # Hyprlock
  hyprlock = import ./config/hyprlock.nix;

  # Hypridle
  hypridle = import ./config/hypridle.nix;

  pyprland-config = import ./config/pyprland.nix;

  wallpaperPath = ./config/wallpapers/sky-butterfly.jpg;

  colorPalette = config.colorScheme.palette;

  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 1

    ${pkgs.swww}/bin/swww img ${wallpaperPath} &

    pypr &

    wl-paste --type text --watch cliphist store &
    wl-paste --type image --watch cliphist store &

    dunst &
  '';

in {

  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.hypridle.homeManagerModules.default
    environment
    waybar
    animations
    windowrules
    colors
    keybinds
    pyprland-config
    hypridle
    hyprlock
  ];

  home.packages = (with pkgs; [
    # Hyprland
    rofi-wayland
    pyprland
    wl-clipboard
    swww
    eww

    (pkgs.writeShellScriptBin "reload-wallpaper" ''
      ${pkgs.swww}/bin/swww img ${wallpaperPath}
    '')
  ]);

  services = {
    cliphist = { enable = true; };
    dunst = { enable = true; };
  };
  home.file.".wallpapers".source = ./config/wallpapers;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      general = {
        gaps_in = 3;
        gaps_out = 8;
        border_size = 4;
        "col.active_border" = "$base0C";
        "col.inactive_border" = "$base01";
        layout = "dwindle";
        resize_on_border = true;
      };
      decoration = {
        rounding = 4;
        drop_shadow = false;
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = "on";
          ignore_opacity = "on";
          xray = false;
        };
      };
      layerrule = "blur,waybar";
      #group = {
      #  "col.border_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
      #  "col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      #  "col.border_locked_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
      #  "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      #};

      exec-once = "${startupScript}/bin/start";

      monitor = [ "HDMI-A-1, 1920x1080, 0x0, 1" "DP-2, 1366x768, 1920x0, 1" ];
    };
    extraConfig = ''
      # This is an example Hyprland config file.
      #
      # Refer to the wiki for more information.

      #
      # Please note not all available settings / options are set here.
      # For a full list, see the wiki
      #

      # See https://wiki.hyprland.org/Configuring/Monitors/
      #monitor=,preferred,auto,auto

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = false
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }


      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = false
      }

      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
      }

    '';
  };
}
