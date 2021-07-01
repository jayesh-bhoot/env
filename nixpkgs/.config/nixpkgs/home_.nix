{ config, pkgs, ... }:

{
  programs.home-manager = {
    enable = true;
  };

  imports = [
    ./modules/packages
    ./modules/inputrc
    ./modules/bash
    ./modules/zsh
    ./modules/git
    ./modules/fzf
    ./modules/neovim
    ./modules/ideavimrc
    ./modules/fonts
    ./modules/gtk
  ];
}
