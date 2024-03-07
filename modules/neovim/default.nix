{ inputs, config, lib, pkgs, ... }:
let
  keymaps = import ./modules/keymaps.nix;
  cmp = import ./modules/cmp.nix;
  lsp = import ./modules/lsp.nix;
  alpha = import ./modules/alpha.nix;
  autoCmd = import ./modules/autocommands.nix;
in {
  imports =
    [ inputs.nixvim.homeManagerModules.nixvim alpha keymaps lsp cmp autoCmd ];

  programs.nixvim = {
    enable = true;
    clipboard = {
      register = "unnamedplus";
      providers = { wl-copy.enable = true; };
    };
    colorschemes.base16 = {
      enable = true;
      useTruecolor = true;
      #colorscheme = lib.toLower config.colorScheme.slug;
      customColorScheme = with config.colorScheme.palette; {
        base00 = "#${base00}";
        base01 = "#${base01}";
        base02 = "#${base02}";
        base03 = "#${base03}";
        base04 = "#${base04}";
        base05 = "#${base05}";
        base06 = "#${base06}";
        base07 = "#${base07}";
        base08 = "#${base08}";
        base09 = "#${base09}";
        base0A = "#${base0A}";
        base0B = "#${base0B}";
        base0C = "#${base0C}";
        base0D = "#${base0D}";
        base0E = "#${base0E}";
        base0F = "#${base0F}";

      };
    };

    autoGroups = { lint = { clear = true; }; };

    globals.mapleader = " ";

    viAlias = true;
    vimAlias = true;

    plugins = {
      nvim-autopairs = {
        enable = true;
        enableAbbr = true;
        enableCheckBracketLine = true;
        mapBs = true;
        mapCH = true;
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

      };
      treesitter.enable = true;
      luasnip.enable = true;
      nix.enable = true;
      neocord = { enable = true; };
      tmux-navigator = { enable = true; };
      surround = { enable = true; };
      trouble = { enable = true; };

      better-escape = { enable = true; };

      lualine = { enable = true; };
    };
    extraPlugins = with pkgs.vimPlugins; [ lazygit-nvim nvim-web-devicons ];
  };
}
