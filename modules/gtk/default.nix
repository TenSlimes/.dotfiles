{ pkgs, ... }: {
  gtk.enable = true;
  gtk.iconTheme = {
    package = pkgs.rose-pine-icon-theme;
    name = "rose-pine-moon";
  };
}
