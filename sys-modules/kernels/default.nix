{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams =
      [ "amd_iommu=on" "amd_iommu=pt" "amd_pstate=active" "kvm.ignore_mrs=1" ];
  };
}
