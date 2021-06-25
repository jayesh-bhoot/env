{ config, pkgs, ... }:

# https://github.com/nix-community/home-manager/blob/master/modules/programs/neovim.nix
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [ 
      vim-nix
      papercolor-theme
    ];
    extraConfig = builtins.readFile ../configs/vimrc;
  };
}
