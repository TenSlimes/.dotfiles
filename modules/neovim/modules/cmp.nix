{ ... }: {
  programs.nixvim.plugins = {
    #CMP
    nvim-cmp = {
      enable = true;
      completion = { autocomplete = [ "TextChanged" ]; };
      snippet.expand = "luasnip";
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
      window = {
        completion.border = [ "" "" "" "" "" "" "" "" ];
        documentation.border = [ "" "" "" "" "" "" "" "" ];
      };
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = {
          action = "cmp.mapping.select_prev_item()";
          modes = [ "i" "s" ];
        };
        "<Tab>" = {
          action = "cmp.mapping.select_next_item()";
          modes = [ "i" "s" ];
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
