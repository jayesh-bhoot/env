{ config, pkgs, ... }:

{
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscodium;
  #   extensions = [
  #   ];
  # };

  xdg.configFile."VSCodium/User/settings.json".source = ../configs/vscodium/settings.json;
  xdg.configFile."VSCodium/User/keybindings.json".source = ../configs/vscodium/keybindings.json;
}
