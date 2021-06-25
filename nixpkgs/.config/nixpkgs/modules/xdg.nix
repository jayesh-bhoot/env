{ config, pkgs, ... }:

{
  xdg.enable = true;

  xdg.configFile."ideavim/ideavimrc".source = ../configs/ideavimrc;
  home.file.".inputrc".source = ../configs/inputrc;
}
