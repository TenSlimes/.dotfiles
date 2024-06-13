{ inputs, pkgs, ... }: {
  imports = [ inputs.nixvim.homeManagerModules.nixvim ./modules ];

  # TODO: Testing

  # NOTE: WE WE WE

  programs.nixvim = {
    enable = true;

    #colorschemes.catppuccin = {
    #  enable = true;
    #  settings = {
    #    flavour = "mocha";
    #    integrations = {
    #      cmp = true;
    #      notify = true;
    #      treesitter = true;
    #    };
    #  };
    #};

    clipboard = {
      register = "unnamedplus";
      providers = { wl-copy.enable = true; };
    };

    autoGroups = { lint = { clear = true; }; };

    globals.mapleader = " ";

    viAlias = true;
    vimAlias = true;

    plugins = {
      nvim-autopairs = {
        enable = true;
        settings = {
          map_bs = true;
          map_ch = true;
          enable_abbr = true;
          enable_check_bracket_line = true;
        };
      };
      notify = { enable = true; };
      which-key = { enable = true; };
      noice = { enable = true; };

      bufferline = {
        enable = true;
        mode = "buffers";
        diagnostics = "nvim_lsp";
        offsets = [{
          filetype = "NvimTree";
          text = "File Explorer";
          highlight = "Directory";
          separator = true;
        }];
      };

      telescope.enable = true;
      oil.enable = true;
      nvim-tree = {
        enable = true;
        autoClose = true;
        filters = { dotfiles = true; };
      };
      treesitter.enable = true;
      luasnip.enable = true;
      nix.enable = true;
      tmux-navigator = { enable = true; };
      surround = { enable = true; };
      trouble = { enable = true; };

      todo-comments = { enable = true; };

      better-escape = { enable = true; };

      lualine = { enable = true; };
      neocord.enable = true;

      emmet = { enable = true; };

      startify = { enable = true; };

    };
    extraPlugins = with pkgs.vimPlugins; [ nvim-web-devicons ];
  };
}
