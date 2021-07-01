{ config, pkgs, ... }:

{
  xdg.configFile."ideavim/ideavimrc".source = ./ideavimrc;
}
