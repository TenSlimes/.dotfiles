{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      eval (${pkgs.tmuxifier}/bin/tmuxifier init - fish)
    '';
    shellAliases = {
      rebuild-home = "home-manager switch --flake . ";
      rebuild-system = "sudo nixos-rebuild switch --flake .";
    };
  };
}
