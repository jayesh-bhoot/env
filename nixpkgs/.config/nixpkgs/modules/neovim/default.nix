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
      vim-ocaml
    ];
    extraConfig = builtins.readFile ./init.vim;
  };
}
