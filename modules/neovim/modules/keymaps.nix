{ ... }: {
  programs.nixvim = {
    keymaps = [
      # Equivalent to nnoremap ; :
      {
        key = ";";
        action = ":";
      }

      # Equivalent to nmap <silent> <buffer> <leader>gg <cmd>Man<CR>
      {
        key = "<leader>gg";
        action = "<cmd>Man<CR>";
        options = {
          silent = true;
          remap = false;
        };
      }
      # Nvim Tree
      {
        mode = "n";
        key = "<c-n>";
        action = ":NvimTreeFindFileToggle<CR>";
        options = {
          silent = true;
          desc = "Toggle Vim Tree";
        };
      }

      # Telescope
      {
        mode = "n";
        key = "<c-p>";
        action = ''
          require('telescope.builtin').find_files
        '';
        lua = true;
        options = { desc = "Find files"; };
      }
      {
        mode = "n";
        key = "<Space><Space>";
        action = ''
          require('telescope.builtin').oldfiles
        '';
        lua = true;
        options = { desc = "Telescope old files"; };
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = ''
          require('telescope.builtin').live_grep
        '';
        lua = true;
        options = { desc = "Telescope Live Grep"; };
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = ''
          require('telescope.builtin').help_tags
        '';
        lua = true;
        options = { desc = "Help tags for telescope"; };
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = ''
          require('telescope.builtin').buffers
        '';
        lua = true;
        options = { desc = "Find buffers"; };
      }
      {
        mode = "n";
        key = "<leader>gf";
        lua = true;
        action = ''
          function()
            vim.lsp.buf.format()
          end
        '';
        options = { desc = "Format file"; };
      }

      {
        mode = "n";
        key = "<leader>bl";
        action = ":BufferLinePick<CR>";
        options = {
          silent = true;
          desc = "Pick buffer line";
        };
      }

      # Bufferline
      {
        mode = "n";
        key = "<leader>bp";
        action = "<Cmd>BufferLineTogglePin<CR>";
        options.desc = "Toggle pin";
      }
      {
        mode = "n";
        key = "<leader>bP";
        action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
        options.desc = "Delete non-pinned buffers";
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<Cmd>BufferLineCloseOthers<CR>";
        options.desc = "Delete other buffers";
      }
      {
        mode = "n";
        key = "<leader>br";
        action = "<Cmd>BufferLineCloseRight<CR>";
        options.desc = "Delete buffers to the right";
      }
      {
        mode = "n";
        key = "<leader>bl";
        action = "<Cmd>BufferLineCloseLeft<CR>";
        options.desc = "Delete buffers to the left";
      }
      {
        mode = "n";
        key = "<S-h>";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "Prev buffer";
      }
      {
        mode = "n";
        key = "<S-l>";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "[b";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "Prev buffer";
      }
      {
        mode = "n";
        key = "]b";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "Next buffer";
      }
    ];
  };
}
