{ userSettings, inputs, config, pkgs, pkgs-stable, ... }:
let
  terminalConfig = userSettings.terminal;
  useKitty = if (terminalConfig.emulator == "kitty") then true else false;
  useFish = if (terminalConfig.shell == "fish") then true else false;
  useZsh = if (terminalConfig.shell == "zsh") then true else false;
in {
  imports = [
    ./obs.nix

    ./fzf.nix

    ./firefox.nix
  ];

  home.packages = (with pkgs-stable; [
    # Discord
    #webcord-vencord
    # Just anime stuff
    mpv
    ani-cli
    openvpn
    ranger
  ]) ++ (with pkgs; [

    krita
    atlauncher
    lazygit
    gamemode

    vesktop
    easyeffects

    tmuxifier
  ]);

  programs.nix-index.enable = true;

  programs.git = {
    enable = true;
    userEmail = config.sops.secrets.github_email;
    userName = config.sops.secrets.github_username;
  };
}
