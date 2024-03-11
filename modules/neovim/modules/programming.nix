{ ... }: {
  programs.nixvim.plugins = {
    # Rust
    rustacenvim = { enable = true; };
  };
}
