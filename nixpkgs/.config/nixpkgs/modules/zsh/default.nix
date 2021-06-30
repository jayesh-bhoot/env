{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initExtra = builtins.readFile ../session-env.sh + "\n" + builtins.readFile ./zshrc;
  };
}
