{ ... }: {
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      capabilities = ''
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      '';
      servers = {
        tsserver.enable = true;
        lua-ls.enable = true;
        #nixd.enable = true;
        svelte = {
          enable = true;
          initOptions = {
            svelte = { plugin = { svelte.format = { enable = true; }; }; };
          };
        };

        html.enable = true;
        tailwindcss = { enable = true; };
        cssls.enable = true;

        rust-analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };

        dockerls = { enable = true; };

        dartls = {
          enable = true;

        };

      };
    };

    lsp-format = { enable = true; };

    lspkind = {
      enable = true;
      cmp = { enable = true; };
    };

    none-ls = {
      enable = true;
      enableLspFormat = true;
      sources = {
        formatting = {
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
          };
          nixfmt = { enable = true; };
        };
      };
    };
  };
}
