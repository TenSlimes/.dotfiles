{ userSettings, ... }:
let
  terminalConfig = userSettings.terminal;
  nvidiaEnv = import ./nvidia.nix;
in {
  imports = [ nvidiaEnv ];
  wayland.windowManager.hyprland.settings = {
    # Set programs that you use
    "$terminal" = (if (terminalConfig.emulator == "kitty") then
      "kitty"
    else
      (if (terminalConfig.emulator == "alacritty") then
        "alacritty"
      else
        "xterm"));
    "$fileManager" = "dolphin";
    "$menu" = "rofi -show drun";
    "$browser" = "firefox";
    env = [
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "QT_QPA_PLATFORM,wayland"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "MOZ_ENABLE_WAYLAND,1"
      "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
    ];
  };
}
