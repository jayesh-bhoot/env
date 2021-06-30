{ config, pkgs, ... }:

{
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscodium;
  #   extensions = [
  #   ];
  # };

  xdg.configFile."VSCodium/User/settings.json".source = ./settings.json;
  xdg.configFile."VSCodium/User/keybindings.json".source = ./keybindings.json;
}
