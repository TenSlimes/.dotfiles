{ pkgs, userSettings, inputs, ... }:
let
in {
  stylix.enable = true;

  stylix.base16Scheme = userSettings.base16;

  stylix.image = userSettings.wallpaper;

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

  #stylix.targets = {
  #  fish.enable = true;
  #  kitty.enable = true;
  #  kitty.variant256Colors = true;
  #  gtk.enable = true;
  #  hyprland.enable = true;
  #  nixvim.enable = true;
  #  lazygit.enable = true;
  #  rofi.enable = true;
  #  tmux.enable = true;
  #  zathura.enable = true;
  #};

}
