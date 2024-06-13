{ ... }: {
  services.udev.extraRules = ''
     KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
    # XP-Pen Deco M
    KERNEL=="hidraw*", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0936", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0936", TAG+="uaccess", TAG+="udev-acl"
    SUBSYSTEM=="input", ATTRS{idVendor}=="28bd", ATTRS{idProduct}=="0936", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
}
