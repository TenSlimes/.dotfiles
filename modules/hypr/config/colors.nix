{ pkgs, config, inputs, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib;

  colors = config.colorScheme.palette;

  convertToRGB = color: toString (nix-colors-lib.conversions.hexToRGB color);

in {
  wayland.windowManager.hyprland.settings = {
    "$base00" = "rgb(${colors.base00})";
    "$base01" = "rgb(${colors.base01})";
    "$base02" = "rgb(${colors.base02})";
    "$base03" = "rgb(${colors.base03})";
    "$base04" = "rgb(${colors.base04})";
    "$base05" = "rgb(${colors.base05})";
    "$base06" = "rgb(${colors.base06})";
    "$base07" = "rgb(${colors.base07})";
    "$base08" = "rgb(${colors.base08})";
    "$base09" = "rgb(${colors.base09})";
    "$base0A" = "rgb(${colors.base0A})";
    "$base0B" = "rgb(${colors.base0B})";
    "$base0C" = "rgb(${colors.base0C})";
    "$base0D" = "rgb(${colors.base0D})";
    "$base0E" = "rgb(${colors.base0E})";
    "$base0F" = "rgb(${colors.base0F})";
    ##"$base" = "0xff191724";
    #"$surface" = "0xff1f1d2e";
    #"$overlay" = "0xff26233a";
    #"$muted" = "0xff6e6a86";
    #"$subtle" = "0xff908caa";
    #"$text" = "0xffe0def4";
    #"$love" = "0xffeb6f92";
    "$gold" = "0xfff6c177";
    #"$rose" = "0xffebbcba";
    #"$pine" = "0xff31748f";
    #"$foam" = "0xff9ccfd8";
    #"$iris" = "0xffc4a7e7";
    #"$highlightLow" = "0xff21202e";
    #"$highlightMed" = "0xff403d52";
    #"$highlightHigh" = "0xff524f67";
  };
}
