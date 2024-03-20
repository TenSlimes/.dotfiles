{ userSettings, lib, inputs, config, pkgs, ... }:
let

  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };

  userTheme = userSettings.theme;
in {
  imports = [
    ./modules
    inputs.nix-index-database.hmModules.nix-index
    inputs.nix-colors.homeManagerModules.default
    inputs.sops-nix.homeManagerModules.sops
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  #colorScheme = inputs.nix-colors.colorSchemes.${userSettings.colors.slug};
  colorScheme = if (userTheme.colorScheme == userTheme.wallpaperPath) then
    nix-colors-lib.colorSchemeFromPicture {
      path = userTheme.wallpaperPath;
      variant = userTheme.variant;
    }
  else
    inputs.nix-colors.colorSchemes.${userTheme.colorScheme};

  home.username = "alit";
  home.homeDirectory = "/home/alit";

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors;
      name = "mochaDark";
    };
  };

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "FiraCode" ]; })
  ];

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      associations.added = { "application/pdf" = [ "zathura.desktop" ]; };
      defaultApplications = { "application/pdf" = [ "zathura.desktop" ]; };
    };
  };

  home.sessionVariables = { EDITOR = "nvim"; };

  programs = { home-manager.enable = true; };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "steam" "steam-original" "steam-run" ];

  nixpkgs.config.allowUnfree = true;
}
