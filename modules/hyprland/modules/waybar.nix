{ ... }: {
  waybar = {
    enable = true;
    settings = {
      layer = "top";
      position = "bottom";
      mod = "dock";
      height = 31;
      exclusive = true;
      reload_style_on_change = true;

      modules-left = [ "custom/padd" ];
      modules-center = [ ];
      modules-right = [ ];

    };
  };
}
