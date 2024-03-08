{ userSettings, ... }:
let emulator = userSettings.terminal.emulator;
in {
  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
      "magnify",
      "shift_monitors",
      "layout_center"
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "${emulator} --class scratchpads-${emulator}-dropterm"
    class = "scratchpads-${emulator}-dropterm"
    size = "50% 50%"
    margin = 50
    unfocus = "hide"

    [scratchpads.easyeffects]
    animation = "fromBottom"
    command = "easyeffects"
    class = "scratchpads-easyeffects"
    size = "40% 40%"
    margin = 50
    unfocus = "hide"
    lazy = "true"


    [layout_center]
    margin = 60
    offset = [0, 30]
    next = "movefocus r"
    prev = "movefocus l"
    next2 = "movefocus d"
    prev2 = "movefocus u"

  '';

}
