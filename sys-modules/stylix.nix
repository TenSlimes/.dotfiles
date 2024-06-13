{ pkgs, userSettings, ... }:
let
in {
  stylix.enable = true;
  stylix.image = userSettings.wallpaper;
  stylix.base16Scheme = userSettings.base16;
  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };

  stylix.cursor = {
    size = 15;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
  };

  stylix.autoEnable = true;
}
