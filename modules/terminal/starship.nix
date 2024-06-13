{ lib, ...}:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true; 
    settings = {
      add_newline = true;
      format = lib.concatStrings [ "$directory" "$character" ];
      right_format = lib.concatStrings [ "$all" ];

      rust = {
        format = lib.concatStrings [ " [$symbol$version]" "(red bold)" ];
      };
      package = {
        format = lib.concatStrings [ "[$symbol $version]" "(208 bold)" ];
      };
    };
  };
}
