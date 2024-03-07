{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    mouse = true;
    plugins = (with pkgs.tmuxPlugins; [

      yank

      vim-tmux-navigator

      sensible

      catppuccin
    ]);
    keyMode = "vi";
    extraConfig = ''

      set -g status-left "#[fg=blue,bold,bg=#1e1e2e] 󱄅 #S"

      set -g status-right "#[fg=#b4befe,bold,bg=#1e1e2e]%a %Y-%m-%d 󰥔 %l:%M %p"

      set -g window-status-current-format "#[fg=magenta,bg=#1e1e2e] *#I  #W"

      set -g window-status-last-style "fg=white,bg=black"

      set -g status-position top

      set -g status-style 'bg=#1e1e2e'

      set -g status-justify left

      set -g @catppuccin_flavour 'mocha'

      bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt

      set -g detach-on-destroy off  # don't exit from tmux when closing a session

      set -g @t-fzf-prompt '  '

      set  -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",alacritty:RGB"
    '';
    sensibleOnTop = true;
    baseIndex = 1;
    shortcut = "s";
    newSession = true;
  };
}
