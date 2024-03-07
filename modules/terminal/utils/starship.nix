{ userSettings, lib, ... }:
let shellConfig = userSettings.terminal.shell;
in {
  programs.starship = {
    enable = true;
    enableFishIntegration = if (shellConfig == "fish") then true else false;
    enableZshIntegration = if (shellConfig == "zsh") then true else false;

    settings = {
      add_newline = false;
      format = lib.concatStrings [ "$directory" "$character" ];
      right_format = lib.concatStrings [ "$all" ];
    };
  };
}
