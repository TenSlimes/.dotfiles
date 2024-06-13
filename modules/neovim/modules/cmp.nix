{ ... }: {
  programs.nixvim.plugins = {
    #CMP
    cmp = {
      enable = true;
      autoEnableSources = false;
      settings = {
        completion = { autocomplete = [ "TextChanged" ]; };
        sources = {
          __raw = ''
            cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
            }, {
              { name = 'buffer' },
              { name = 'path' },
            })

          '';
        };
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';

        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
      };
    };
    cmp_luasnip.enable = true;
    cmp-buffer.enable = true;
    cmp-dictionary.enable = true;
    cmp-fish.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-cmdline.enable = true;
    cmp-nvim-lsp-document-symbol.enable = true;
    friendly-snippets.enable = true;
  };
}
