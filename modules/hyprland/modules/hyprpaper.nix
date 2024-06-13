{ userSettings, inputs, ... }:
let
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${userSettings.wallpaper}" ];
      wallpaper = "HDMI-A-1,${userSettings.wallpaper}";
      splash = false;
    };
  };
}
