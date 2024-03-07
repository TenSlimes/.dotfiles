{ pkgs, userSettings, ... }:
let
  terminalConfig = userSettings.terminal;
  useZsh = if (terminalConfig.shell == "zsh") then true else false;
in {
  programs.zsh = {
    enable = useZsh;
    autocd = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = { update-home = "home-manager switch --flake ."; };
    history = {
      size = 1000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
    };
    zplug = {
      enable = true;

      plugins = [{ name = "zsh-users/zsh-autosuggestions"; }];
    };
  };
  #home.packages = if useZsh then (with pkgs; [ zsh-autosuggestions ]) else [ ];
}
