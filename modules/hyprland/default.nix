{ pkgs, inputs, ... }: {

  imports = [ inputs.hyprland.homeManagerModules.default ./modules ];

  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
    debug = { disable_logs = false; };
  };

  home.packages = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xwaylandvideobridge

    waybar

    killall
  ];

}
