{ config, pkgs, ... }:

{
  programs.home-manager = {
    enable = true;
  };

  imports = [
    ./modules/packages.nix
    ./modules/xdg.nix
    ./modules/env-vars.nix
    ./modules/nixpkgs-config.nix
    ./modules/fonts.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/fzf.nix
    ./modules/bash.nix
    ./modules/neovim.nix
    ./modules/gtk.nix
  ];
}
