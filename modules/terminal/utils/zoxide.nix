{ config, userSettings, ... }:
let
  terminalConfig = userSettings.terminal;
  useFish = if (terminalConfig.shell == "fish") then true else false;
  useZsh = if (terminalConfig.shell == "zsh") then true else false;
in {

  programs.zoxide = {
    enable = true;
    enableFishIntegration = useFish;
    enableZshIntegration = useZsh;
    enableBashIntegration = if (useFish == useZsh) then true else false;
  };
}
