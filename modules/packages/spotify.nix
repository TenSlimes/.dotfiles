{ lib, config, pkgs, ... } :
{
  home.packages = (with pkgs; [
    spotify-tui
  ])
  services.spotifyd = {
    enable = true;
    global = {
      
    };
  };
}
