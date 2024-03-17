{ ... }: {
  programs.nixvim.plugins = {
    # Rust
    rustaceanvim = { enable = true; };
  };
}
