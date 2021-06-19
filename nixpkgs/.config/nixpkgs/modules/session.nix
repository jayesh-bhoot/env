{ config, pkgs, ... }:


{
  home.sessionPath = [
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    DOTNET_CLI_TELEMETRY_OPTOUT = true;
    LC_ALL = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
  };
}
