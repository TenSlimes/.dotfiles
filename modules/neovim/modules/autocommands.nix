{ ... }: {
  programs.nixvim.autoCmd = [

    {
      event = [ "FileType" ];
      pattern = [ "json" "javascript" "typescript" "svelte" "css" "html" ];
      command = "setlocal tabstop=2 shiftwidth=2 expandtab";
    }
  ];
}
