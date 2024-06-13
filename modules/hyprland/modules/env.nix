{ ... }: {

  wayland.windowManager.hyprland.settings = {
    env = [
      "XCURSOR_SIZE,17"
      "XDG_SESSION_TYPE,wayland"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "HYPRCURSOR_SIZE,17"
    ];
  };
}
