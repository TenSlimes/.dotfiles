{
  description = "Just some weird flake";

  inputs = {

    nixpkgs = { url = "nixpkgs/nixos-unstable"; };

    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/Hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyprland = {
      url = "github:hyprland-community/pyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = { url = "github:misterio77/nix-colors"; };

  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, hyprland, hyprlock
    , nixvim, nix-colors, ... }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux";
        hostname = "tenslime";
      };

      colors = { slug = "catppuccin-frappe"; };

      terminal = {
        emulator =
          "kitty"; # only kitty or alacritty, I swear if u put something else, it will use xterm
        shell = "fish"; # zsh or fish, anything else will be returned to bash
      };

      userSettings = rec {
        username = "alit";
        inherit terminal;
        inherit colors;
      };

      lib = nixpkgs.lib;

      pkgs = nixpkgs.legacyPackages.${systemSettings.system};

      pkgs-stable = nixpkgs-stable.legacyPackages.${systemSettings.system};

    in {
      nixosConfigurations = {
        tenslime = lib.nixosSystem {
          system = systemSettings.system;
          specialArgs = {
            inherit inputs;
            inherit pkgs-stable;
            inherit systemSettings;
            inherit userSettings;
          };
          modules = [
            ./configuration.nix
            ./hardware-configuration.nix
            hyprland.nixosModules.default
            { programs.hyprland.enable = true; }
          ];
        };
      };
      homeConfigurations = {
        ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit inputs;
            inherit pkgs-stable;
            inherit userSettings;
          };
        };
      };
    };
}
