{ systemSettings, ... }:
let nvidiaSettings = systemSettings.gpu.nvidia;
in {
  wayland.windowManager.hyprland.settings = {
    env = if (nvidiaSettings.enable && nvidiaSettings.open == false) then [
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "__GL_VRR_ALLOWED,1"
      "WLR_NO_HARDWARE_CURSORS,1"
      "WLR_DRM_NO_ATOMIC,1"
      "WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"
    ] else
      [ ];
  };
}
