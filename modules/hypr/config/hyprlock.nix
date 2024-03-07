{ inputs, config, lib, ...}:
{
  imports = [
     inputs.hyprlock.homeManagerModules.default
  ];
  programs = {
    hyprlock = {
      enable = true;
    };
  };
}
