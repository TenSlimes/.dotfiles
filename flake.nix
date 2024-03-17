{
  description = "Just some weird flake";

  nixConfig = {
    extra-subtituters = [
      "https://cache.nixos.org"

      # nix community's cache server
      "https://nix-community.cachix.org"

      "https://hyprland.cachix.org"
    ];

    extra-trusted-public-keys = [
      # nix community's cache server public key
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {

    nixpkgs = { url = "nixpkgs/nixos-unstable"; };

    # Just incase I want the stable version
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    sops-nix.url = "github:Mic92/sops-nix";

    rust-overlay = { url = "github:oxalica/rust-overlay"; };

  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixvim, nix-colors, ... }@inputs:
    let

      systemSettings = {
        system = "x86_64-linux";
        hostname = "tenslime";
        gpu = {
          nvidia = {
            enable = true;
            open = false; # Open source version, literally open source duh
          };
        };
      };

      terminal = {
        emulator =
          "kitty"; # only kitty or alacritty, I swear if u put something else, it will use xterm
        shell = "fish"; # zsh or fish, anything else will be returned to bash
      };

      theme = {
        wallpaperPath = ./wallpapers/astronaut-anime-girl.jpg;
        colorScheme =
          theme.wallpaperPath; # or wallpaperPath (generate colorscheme from wallpaper)
        variant =
          "dark"; # dark or light | the variant will only work if you use wallpaperPath as colorScheme;
      };

      userSettings = rec {
        username = "alit";
        inherit terminal;
        inherit theme;
      };

      lib = nixpkgs.lib;

      pkgs = nixpkgs.legacyPackages.${systemSettings.system};

      pkgs-stable = nixpkgs-stable.legacyPackages.${systemSettings.system};

      #overlay-nixpkgs = final: prev:
      # { } ++ ((import inputs.rust-overlay.overlays.default));
      overlay-nixpkgs = [ inputs.rust-overlay.overlays.default ];

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
            inputs.hyprland.nixosModules.default
            inputs.sops-nix.nixosModules.sops
            { nix.settings.trusted-users = [ "alit" ]; }
            ({ pkgs, ... }: {
              nixpkgs.overlays = overlay-nixpkgs;

              programs.hyprland.enable = true;
              environment.systemPackages = with pkgs; [
                rust-bin.stable.latest.default
                cargo
                gcc
              ];

            })
          ];
        };
      };
      homeConfigurations = {
        ${userSettings.username} =
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home.nix ];
            extraSpecialArgs = {
              inherit inputs;
              inherit pkgs-stable;
              inherit systemSettings;
              inherit userSettings;
            };
          };
      };
    };
}
