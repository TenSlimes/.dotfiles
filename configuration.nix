# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ userSettings, config, lib, pkgs, inputs, ... }:
let
  terminalConfig = userSettings.terminal;

  useZsh = if (terminalConfig.shell == "zsh") then true else false;

  useFish = if (terminalConfig.shell == "fish") then true else false;
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

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

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" "amdgpu" ];
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

  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  # };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # rtkit is optional but recommended
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
    #(mesa.overrideAttrs (oldAttrs: {
    #  vulkanDrivers = ["nouveau-experimental"];
    #}))

    eza

    htop

    ripgrep

    vulkan-tools

    temurin-bin-21
    temurin-bin-8

    wineWowPackages.staging
    winetricks

  ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
