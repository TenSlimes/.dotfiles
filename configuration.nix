{ inputs, lib, config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./sys-modules
    <home-manager/nixos>
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jayapura";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  programs.hyprland.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.lightdm = {
      enable = true;
      extraSeatDefaults = ''
        autologin-user=tenslime
      '';
    };
    xkb = {
      variant = "";
      layout = "us";
    };
    excludePackages = [ pkgs.xterm ];
  };

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #AMD
  hardware.opengl.driSupport = true; # This is already enabled by default
  hardware.opengl.driSupport32Bit = true; # For 32 bit applications

  environment.variables = { ROC_ENABLE_PRE_VEGA = "1"; };

  programs.fish.enable = true;

  users.users.tenslime = {
    isNormalUser = true;
    description = "TenSlime";
    extraGroups = [ "networkmanager" "wheel" "docker" "autologin" "libvirtd" ];
    packages = with pkgs; [ fish ];
    shell = pkgs.fish;
  };

  programs.steam = {
    enable = true;
    gamescopeSession = { enable = true; };
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    openvpn
    openresolv
    gnome.networkmanager-openvpn
    lzip
    pciutils
    gh
    eza
    python3
    gnumake
    libgcc
  ];

  virtualisation.waydroid.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = { data-root = "/mnt/Data/Docker/"; };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # VPN
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  services.gvfs.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "steam" "steam-original" "steam-run" ];

  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
