{ config, pkgs, ... }:

{
  programs.home-manager = {
    enable = true;
  };

  imports = [
    # ./modules/inputrc
    # ./modules/bash
    # ./modules/git
    # ./modules/fzf
    # ./modules/neovim
    # ./modules/ideavimrc
    # ./modules/fonts
    # ./modules/gtk
  ];
}
