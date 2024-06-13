{ pkgs, ... }:
let
  nuclear-xdg = pkgs.pkgs.writeShellScriptBin "nuclear-xdg" ''
    sleep 1
    ${pkgs.killall}/bin/killall -e xdg-desktop-portal-hyprland
    ${pkgs.killall}/bin/killall -e xdg-desktop-portal-wlr
    ${pkgs.killall}/bin/killall xdg-desktop-portal
    ${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland &
    sleep 2
    ${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal &
  '';
in {

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.hypridle}/bin/hypridle &"
      "${pkgs.dunst}/bin/dunst &"
      "${nuclear-xdg}/bin/nuclear-xdg &"
      "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1 &"
      "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store &" # Stores only text data
      "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store &" # Stores only image
      "${pkgs.udiskie}/bin/udiskie &"
      "${pkgs.hyprpaper}/bin/hyprpaper &"
      "${pkgs.waybar}/bin/waybar &"
      "${pkgs.pyprland}/bin/pypr &"
    ];
  };
}
