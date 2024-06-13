{ pkgs, ... }:
let
  opacity-size = "0.9";
  opacity = "opacity ${opacity-size} ${opacity-size}";
in {

  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Xwayland screenshare
      "opacity 0.0 override,class:^(xwaylandvideobridge)$"
      "noanim,class:^(xwaylandvideobridge)$"
      "noinitialfocus,class:^(xwaylandvideobridge)$"
      "maxsize 1 1,class:^(xwaylandvideobridge)$"
      "noblur,class:^(xwaylandvideobridge)$"
      # Floorp
      "opacity ${opacity},class:^(floorp)$"
      #Kitty
      "opacity ${opacity},class:^(kitty)$"

      #Discord
      "opacity ${opacity},class:^(ArmCord)$"

      # Nautilus
      "opacity ${opacity}, class:^(org.gnome.Nautilus)$"

      # Steam
      "opacity 0.70 0.70,class:^([Ss]team)$"
      "opacity 0.70 0.70,class:^(steamwebhelper)$"

      # KDE POLKIT
      "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"
      "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"

      # Pyprland

    ];
    layerrule = [ "blur,rofi" ];
  };
}
