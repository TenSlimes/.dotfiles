{ config, ... }:
let colors = config.colorScheme.palette;
in {
  programs.kitty.settings = {
    foreground = "#${colors.base05}";
    background = "#${colors.base00}";

    selection_background = "#${colors.base06}";

    cursor = "#${colors.base06}";

    cursor_text_color = "#${colors.base00}";

    url_color = "#${colors.base06}";
    mark1_foreground = "#${colors.base00}";
    mark1_background = "#${colors.base07}";

    mark2_foreground = "#${colors.base00}";
    mark2_background = "#${colors.base0E}";

    mark3_foreground = "#${colors.base00}";

    mark3_background = "#${colors.base0F}";

    # black
    color0 = "#${colors.base03}";
    color8 = "#${colors.base04}";

    #red
    color1 = "#${colors.base08}";
    color9 = "#${colors.base08}";

    # green
    color2 = "#${colors.base0B}";
    color10 = "#${colors.base0B}";

    # yellow
    color3 = "#${colors.base0A}";
    color11 = "#${colors.base0A}";

    # blue
    color4 = "#${colors.base0D}";
    color12 = "#${colors.base0D}";

    #magenta
    color5 = "#${colors.base07}";
    color13 = "#${colors.base07}";

    # cyan
    color6 = "#${colors.base0C}";
    color14 = "#${colors.base0C}";

    #white
    color7 = "#${colors.base0F}";
    color15 = "#${colors.base0E}";

  };
}
