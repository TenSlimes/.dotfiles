{ pkgs, ... }:
let

  toggleWaybar = pkgs.pkgs.writeShellScriptBin "toggleWaybar" ''
    if pgrep waybar >/dev/null; then
    	killall .waybar-wrapped
    else
    	${pkgs.waybar}/bin/waybar &
    fi
  '';

  dontKillSteam = pkgs.pkgs.writeShellScriptBin "dontkillsteam" ''
    if [ "$(hyprctl activewindow -j | jq -r ".class")" = "Steam" ]; then
        xdotool getactivewindow windowunmap
    else
        hyprctl dispatch killactive ""
    fi
  '';

  screenshot = pkgs.pkgs.writeShellScriptBin "screenshot" ''
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy 
  '';

in {
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$CONTROL" = "L_Control";

    bindm =
      [ "$mainMod, mouse:272, movewindow" "$mainMod, mouse:273, resizewindow" ];
    bind = [
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      "$mainMod, T, exec, $terminal"
      "$mainMod, Q, exec, ${dontKillSteam}/bin/dontkillsteam"
      "$mainMod, E, exec, $fileManager"
      "$mainMod, F, exec, $browser"
      "$mainMod ,Alt_L,exec, $browser --private-window"
      "$mainMod, V, togglefloating,"
      "$mainMod, R, exec, $menu"
      #"$mainMod, P, pseudo, # dwindle"
      #"$mainMod, J, togglesplit, # dwindle"
      "$CONTROL, ESCAPE, exec, ${toggleWaybar}/bin/toggleWaybar" # TOGGLE WAYBAR

      # SCREENSHOT

      ", Print, exec, ${screenshot}/bin/screenshot"
      # Move focus with mainMod + arrow keys
      "$mainMod, h, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"
      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
      # Example special workspace (scratchpad)
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"
      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      # Pyprland 
      # layout_center
      "$mainMod, M, exec, pypr layout_center toggle"
      "$mainMod, left, exec, pypr layout_center prev"
      "$mainMod, right, exec, pypr layout_center next"
      "$mainMod, up, exec, pypr layout_center prev2"
      "$mainMod, down, exec, pypr layout_center next2"
      # Scratchpad
      "$mainMod, A, exec, pypr toggle term"
      "$mainMod SHIFT, Z, exec, pypr zoom"
      "$mainMod SHIFT, V, exec, pypr toggle easyeffects"

    ];
  };
}
