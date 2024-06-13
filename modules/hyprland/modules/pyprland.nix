{ pkgs, ... }:
let

  terminal = "${pkgs.kitty}/bin/kitty";

in {
  xdg.configFile."hypr/pyprland.toml".text = ''

    [pyprland]
    plugins = ["scratchpads", "magnify", "layout_center"]

    [layout_center]
    margin = 60
    offset = [0, 30]
    next = "movefocus r"
    prev = "movefocus l"
    next2 = "movefocus d"
    prev2 = "movefocus u"

    [scratchpads.term]
    animation = "fromTop"
    command = "kitty --class kitty-dropterm"
    class = "kitty-dropterm"
    size = "50% 60%"
    max_size = "1920px 100%"
    margin = 50
  '';
}
