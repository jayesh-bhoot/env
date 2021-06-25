{ config, pkgs, ... }:

{
  programs.home-manager = {
    enable = true;
  };

  imports = [
    ./modules/zsh.nix
    ./modules/bash.nix
    ./modules/packages.nix
    ./modules/xdg.nix
    ./modules/nixpkgs-config.nix
    ./modules/git.nix
    ./modules/fzf.nix
    ./modules/neovim.nix
    ./modules/fonts.nix
    ./modules/gtk.nix
  ];
}
