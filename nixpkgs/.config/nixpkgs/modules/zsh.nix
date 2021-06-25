{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initExtra = builtins.readFile ../configs/session-env.sh + "\n" + builtins.readFile ../configs/zshrc;
  };
}
