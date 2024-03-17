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

  home.packages = (with pkgs-stable;
    [
      #webcord-vencord
      # Just anime stuff
    ]) ++ (with pkgs; [

      mpv
      ani-cli
      openvpn
      ranger
      krita

      lazygit
      gamemode

      vesktop
      easyeffects

      tmuxifier

      mongodb-compass

    ]);

  programs.nix-index.enable = true;

}
