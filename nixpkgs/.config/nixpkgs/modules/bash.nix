{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = 
    builtins.readFile ../configs/session-env.sh + "\n" + builtins.readFile ../configs/bashrc;
  };

  xdg.dataFile."bash-completion".source = ~/.nix-profile/share/bash-completion;
  home.sessionVariables.BASH_COMPLETION_USER_DIR = "${config.xdg.dataHome}/bash-completion";
}
