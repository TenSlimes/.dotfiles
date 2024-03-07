{ pkgs, ... }: {
  services.hypridle = {
    enable = true;

    listeners = [{
      timeout = 600; # in seconds.
      onTimeout =
        "${pkgs.dunst}/bin/dunstify 'You are idle!'"; # command to run when timeout has passed.
      onResume =
        "${pkgs.dunst}/bin/dunstify 'Welcome back'"; # command to run when activity is detected after timeout has fired.
    }];
  };
}
