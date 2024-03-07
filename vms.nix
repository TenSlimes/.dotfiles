{ pkgs, pkgs-unstable, config, ... }:
let
  # Change this to your username.
  user = "alit";
  # Change this to match your system's CPU.
  platform = "amd";
  # Change this to specify the IOMMU ids you wrote down earlier.
  vfioIds = [ "10de:2188" "10de:1aeb" ];
in {
  # Configure kernel options to make sure IOMMU & KVM support is on.
  boot = {
    kernelModules = [ 
      "kvm-${platform}" 
      "vfio_virqfd"
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio"
    ];
    kernelParams = [ 
      "${platform}_iommu=on"
      "${platform}_iommu=pt"
      "kvm.ignore_msrs=1"
    ];
    extraModprobeConfig = ''
      options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}
      blacklist nouveau
      options nouveau modeset=0
    '';
    blacklistedKernelModules = [
      "nouveau"
      "nvidia"
      "nvidia_drm"
      "nvidia_modeset"
      "nvidiafb"
    ];
  };

  # Add a file for looking-glass to use later. This will allow for viewing the guest VM's screen in a
  # performant way.
  systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${user} qemu-libvirtd -"
  ];

  # Add virt-manager and looking-glass to use later.
  environment.systemPackages = with pkgs; [
      looking-glass-client
      quickemu
  ];

  programs.virt-manager.enable = true;

  # Enable virtualisation programs. These will be used by virt-manager to run your VM.
  virtualisation = {
     libvirtd = {
       enable = true;
       extraConfig = ''
         user="${user}"
       '';
       # Don't start any VMs automatically on boot.
       onBoot = "ignore";
       # Stop all running VMs on shutdown.
       onShutdown = "shutdown";
       qemu = {
         package = pkgs.qemu_kvm;
         runAsRoot = true;
         swtpm.enable = true;
         ovmf = {
            enable = true;
            packages = [ (pkgs-unstable.OVMF.override {
                tpmSupport = true;
                secureBoot = true;
              }).fd];
          };
         verbatimConfig = ''
           namespaces = []
           user = "+${builtins.toString config.users.users.${user}.uid}"
         '';
       };
    };
    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;

  users.users.${user}.extraGroups = [ "qemu-libvirtd" "libvirtd" "disk" "kvm" ];
}
