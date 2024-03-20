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
      mangal
      ani-cli
      openvpn
      #krita

      lazygit
      gamemode

      easyeffects

      tmuxifier

      mongodb-compass

      webcord

      # Better History Search
      atuin

      # Better disk display
      dust

      # Better cat
      bat

      # Better man
      tldr

      # Android emu

      waydroid

      zathura
    ]);

  programs.nix-index.enable = true;

}
