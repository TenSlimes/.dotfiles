{ pkgs, ... }:
let
  exit = pkgs.pkgs.writeShellScriptBin "exit-app" ''
    if [ "$(hyprctl activewindow -j | jq -r ".class")" = "Steam" ]; then
      ${pkgs.xdotool}/bin/xdotool getactivewindow windowumap
    else
      hyprctl dispatch killactive ""
    fi
  '';

  reload-hyprland = pkgs.pkgs.writeShellScriptBin "reload-hyprland" ''
    hyprctl reload && sleep 1 && ${pkgs.dunst}/bin/dunst "reloaded hyprland"
  '';

  toggle-waybar = pkgs.pkgs.writeShellScriptBin "toggle-waybar" ''
    if pgrep .waybar-wrapped > /dev/null
    then
      ${pkgs.killall}/bin/killall .waybar-wrapped
    else
      ${pkgs.waybar}/bin/waybar
    fi
  '';

  pypr = "${pkgs.pyprland}/bin/pyprland";

in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    "$CONTROL" = "L_Control";

    "$terminal" = "${pkgs.kitty}/bin/kitty";

    "$browser" = "${pkgs.floorp}/bin/floorp";

    "$fileManager" = "${pkgs.gnome.nautilus}/bin/nautilus";

    "$menu" = "${pkgs.rofi-wayland}/bin/rofi";

    bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];

    binde = [
      "$mod&Shift, Right, resizeactive, 30 0"
      "$mod&Shift, Left, resizeactive, -30 0"
      "$mod&Shift, Up, resizeactive, 0 -30"
      "$mod&Shift, Down, resizeactive, 0 30"
    ];

    bind = [
      "$mod, F, exec, $browser"
      "$mod, T, exec, $terminal"
      "$mod, E, exec, $fileManager --new-window"

      "$mod, Q, exec, ${exit}/bin/exit-app"

      "Alt, F4, exec, ${exit}/bin/exit-app"

      "$mod, R, exec, $menu -show drun"

      "$mod&Alt_L, F, exec, $browser --private-window"

      "$mod&$CONTROL, R, exec, hyprctl reload"

      "$CONTROL, Escape, exec, ${toggle-waybar}/bin/toggle-waybar"

      "$mod,F12,fullscreen"

      # Screenshot
      ", Print, exec, ${pkgs.grim}/bin/grim -g '$(${pkgs.slurp}/bin/slurp)' - ${pkgs.wl-clipboard}/bin/wl-copy"

      # Layout Center
      "$mod, M, exec, pypr layout_center toggle"
      "$mod, left, exec, pypr layout_center prev"
      "$mod, right, exec, pypr layout_center next"
      "$mod, up, exec, pypr layout_center prev2"
      "$mod, down, exec, pypr layout_center next2"

      # Scratchpad
      "$mod, A, exec, pypr toggle term"

      # Magnify
      "$mod, Z, exec, pypr zoom ++0.5"
      "$mod& Shift, Z, exec, pypr zoom"
    ] ++ (
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (builtins.genList (x:
        let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          "$mod Alt, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
        ]) 10));
  };
}
