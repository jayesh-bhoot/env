{ config, pkgs, ... }:

{
  xdg.enable = true;

  xdg.configFile."ideavim/ideavimrc".source = ./ideavimrc;
  home.file.".inputrc".source = ./inputrc;
}
