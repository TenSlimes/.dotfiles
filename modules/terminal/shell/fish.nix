{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      ${pkgs.atuin}/bin/atuin init fish | source

      eval (${pkgs.tmuxifier}/bin/tmuxifier init - fish)
    '';
    shellAliases = {
      rebuild-home = ''
        rm ~/.mozilla/firefox/alit/search.json.mozlz4 &
                cd /home/alit/.dotfiles &
                home-manager switch --flake .'';
      rebuild-system = "sudo nixos-rebuild switch --flake .";
      rebuild-all = "rebuild-system && rebuild-home";
    };
  };
}
