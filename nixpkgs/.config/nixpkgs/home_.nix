{ config, pkgs, ... }:

{
  programs.home-manager = {
    enable = true;
  };

  imports = [
    ./modules/bash
    ./modules/zsh
    ./modules/packages
    ./modules/xdg
    ./modules/nixpkgs-config
    ./modules/git
    ./modules/fzf
    ./modules/neovim
    ./modules/fonts
    ./modules/gtk
  ];
}
