{ pkgs, ... }: {
  imports = [ ./kitty ./tmux ./zoxide.nix ./starship.nix ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      ${pkgs.atuin}/bin/atuin init fish | source

      eval (${pkgs.tmuxifier}/bin/tmuxifier init - fish)
    '';
    shellAliases = { };
  };
}
