{ pkgs, config, lib, ... }:
{
  # OBS
  programs.obs-studio = {
    enable = true;
    plugins = (with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-nvfbc
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ]); 
  };
}
