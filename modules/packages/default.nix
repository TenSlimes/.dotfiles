{ pkgs, ... }: {
  imports = [ ./obs.nix ];
  home.packages = with pkgs; [
    gamemode

    mangohud
    python3
    motrix

    mullvad-browser

    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "FiraCode" ]; })

    zathura

    atuin

    zip

    armcord

    floorp

    unrar

    neovide

    onlyoffice-bin

    ripgrep

    r2modman

    #btop

    fastfetch

    wireplumber

    lazygit

    mpv
    ani-cli

    heroic

    dunst

    libsForQt5.ark

    bottles

    mongodb-compass

    # DEV
    nodePackages.nodejs
    corepack

    pyprland

    godot_4

    gnome.nautilus

    gnome.eog
  ];
}
