{ config, userSettings, ... }:
let
  terminalConfig = userSettings.terminal;
  base16 = import ./themes/base16.nix;
in {
  imports = [ base16 ];
  programs.kitty = {
    enable = if (terminalConfig.emulator == "kitty") then true else false;
    settings = {
      font_size = "12.0";
      font_family = "FiraCode Nerd Font";
      bold_font = "FiraCode Nerd Font Bold";
      italic_font = "auto";
      bold_italic_font = "auto";
      window_padding_width = 25;
    };
  };
}
