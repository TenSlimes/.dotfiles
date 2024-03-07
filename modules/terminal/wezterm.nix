{ userSettings, ... }:
let
  terminalConfig = userSettings.terminal;
  useWezterm = if (terminalConfig.emulator == "wezterm") then true else false;
  useFish = if (terminalConfig.shell == "fish") then true else false;
  useZsh = if (terminalConfig.shell == "zsh") then true else false;
in {

  programs.wezterm = {
    enable = if (terminalConfig.emulator == "wezterm") then true else false;
    #colorSchemes = {

    #};
    enableZshIntegration = useZsh;
    enableBashIntegration =
      if (useFish) then true else (if (useFish == useZsh) then true else false);
  };
}
