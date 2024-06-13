{ ... }: {
  imports = [ # Include the results of the hardware scan.
    ./kernels
    ./files.nix
    ./udev.nix
    ./utils.nix
    ./stylix.nix
  ];
}
