{ ... }: {

  fileSystems."/home/alit/Disks/Data" = {
    device = "/dev/disk/by-uuid/B472CC1972CBDE6C";
    fsType = "ntfs-3g";
    options = [ "defaults" "rw" "users" "exec" "gid=100" "uid=1000" ];
  };
  fileSystems."/home/alit/Disks/Games" = {
    device = "/dev/disk/by-uuid/6fd30735-4f6c-428f-bdaa-b3384de3048a";
    fsType = "ext4";
  };
}
