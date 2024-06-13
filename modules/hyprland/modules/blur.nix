{ ... }: {
  wayland.windowManager.hyprland.settings = {
    decoration = {
      blur = {
        enabled = true;
        size = 6;
        passes = 3;
        new_optimizations = true;
        ignore_opacity = true;
        xray = false;
      };
    };
  };
}
