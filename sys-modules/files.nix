{ ... }:
{
  fileSystems."/mnt/Data" = {
    device = "/dev/disk/by-uuid/21cefedf-98f2-44f3-b39b-9644c88ad8ea";
    fsType = "ext4";
  };
  fileSystems."/mnt/Games" = {
    device = "/dev/disk/by-uuid/6fd30735-4f6c-428f-bdaa-b3384de3048a";
    fsType = "ext4";
  };
}
