{ pkgs, inputs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.alit = {
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          }];
        };
      };
      bookmarks = [{
        name = "nixpkgs";
        tags = [ "nix" "nixos" ];
        keyword = "nixpkgs";
        url = "https://search.nixos.org/packages?channel=unstable";
      }];
      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel_shown" = true;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
        "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
      };
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        ublock-origin
        sponsorblock
        darkreader
        youtube-shorts-block
        facebook-container
        multi-account-containers
        privacy-badger
        duckduckgo-privacy-essentials
        auto-tab-discard
        vimium
      ];
    };
  };
}
