{ systemSettings, config, lib, pkgs, modulesPath, ... }:
let nvidiaSettings = systemSettings.gpu.nvidia;
in {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-amd" ]
      ++ (if (nvidiaSettings.enable && nvidiaSettings.open == true) then
        [

        ]
      else
        (if (nvidiaSettings.enable && nvidiaSettings.open == false) then [
          "nvidia"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia_drm"
        ] else
          [ ]));
    kernelParams = [ "amd_iommu=on" "amd_iommu=pt" "kvm.ignore_mrs=1" ]
      ++ (if (nvidiaSettings.enable && nvidiaSettings.open == false) then
        ([ "nvidia_drm.modeset=1" ])
      else
        ([ ]));
    blacklistedKernelModules =
      if (nvidiaSettings.open && nvidiaSettings.enable) then [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ] else
        (if (nvidiaSettings.enable && nvidiaSettings.open == false) then
          [ "nouveau" ]
        else
          [ ]);
    extraModprobeConfig =
      if (nvidiaSettings.open && nvidiaSettings.enable) then ''
        options nouveau.config=NvGspRm=1
      '' else
        "";
    supportedFilesystems = [ "ntfs" ];
  };

  # VM Shit
  users.users.alit.extraGroups = [ "qemu-libvirtd" "libvirtd" "disk" "kvm" ];
}
