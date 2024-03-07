{ config, lib, pkgs, modulesPath, ... }:
let
  vfioIds = [ "10de:2188" "10de:1aeb" ];
in  {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [
      "kvm-amd"
      #"vfio_virqfd"
      #"vfio_pci"
      #"vfio_iommu_type1"
      #"vfio"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
    kernelParams = [
      "amd_iommu=on"
      "amd_iommu=pt"
      "kvm.ignore_mrs=1"
      #"nvidia_drm.modeset=1"
    ];
    blacklistedKernelModules= [
      "nouveau"
     # "nvidia"
     # "nvidia_modeset"
     # "nvidia_uvm"
     # "nvidia_drm"          
    ];
    # options nouveau.config=NvGspRm=1
    #extraModprobeConfig = ''
    #'';
    supportedFilesystems = [ "ntfs" ];
  };

  
# VM Shit
  users.users.alit.extraGroups = ["qemu-libvirtd" "libvirtd" "disk" "kvm"];
}
