# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ userSettings, systemSettings, config, lib, pkgs, inputs, ... }:
let
  terminalConfig = userSettings.terminal;

  useZsh = if (terminalConfig.shell == "zsh") then true else false;

  useFish = if (terminalConfig.shell == "fish") then true else false;

  nvidiaSettings = systemSettings.gpu.nvidia;
in {
  imports = [ # Include the results of the hardware scan.
    ./modules/kernels
    ./hardware-configuration.nix
    ./modules/files
  ];

  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/alit/.config/sops/age/keys.txt";

  sops.secrets = {
    github_username = { owner = config.users.users.alit.name; };

    github_email = { owner = config.users.users.alit.name; };
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "steam" "steam-original" "steam-run" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tenslime"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  security.polkit = { enable = true; };
  # Set your time zone.
  time.timeZone = "Asia/Jayapura";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia =
    if (nvidiaSettings.open == false && nvidiaSettings.enable) then {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    } else
      { };

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ]
      ++ (if (nvidiaSettings.enable) then [ "nvidia" ] else [ ]);
    displayManager = {
      defaultSession = "hyprland";
      autoLogin = {
        enable = true;
        user = "alit";
      };
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };

  programs.steam = {
    enable = true;
    gamescopeSession = { enable = true; };
  };

  services.udev.extraRules = ''
     KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
    # XP-Pen Deco M
    KERNEL=="hidraw*", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0936", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0936", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEM=="input", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0936", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber = { enable = true; };
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alit = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.shells = with pkgs;
    (if useFish then [ pkgs.fish ] else (if useZsh then [ pkgs.zsh ] else [ ]));
  users.defaultUserShell =
    if useZsh then pkgs.zsh else (if useFish then pkgs.fish else "");
  programs.fish.enable = useFish;
  programs.zsh.enable = useZsh;

  environment.systemPackages = (with pkgs; [
    home-manager
    git
    wget
    neofetch
    nodejs_21
    corepack_21
    usbutils
    pciutils
    killall
    glxinfo
    btop

    eza

    htop

    ripgrep

    vulkan-tools

    temurin-bin-21
    temurin-bin-8

    wineWowPackages.staging
    winetricks

    sops

    libva
    libva-utils
    vaapiVdpau

    zenith-nvidia

    mesa

  ]);

  services.openssh.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
