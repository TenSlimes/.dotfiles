{ pkgs, inputs, ... }: {

  services.hypridle = {
    enable = true;
    settings = {

      listeners = [

        {
          timeout = 10;
          onTimeout = "notify-send 'Yoyo mama'";
        }

      ];

    };
  };
}
