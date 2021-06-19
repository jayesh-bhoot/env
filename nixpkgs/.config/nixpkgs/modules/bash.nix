{ config, pkgs, ... }:

{

  xdg.dataFile."bash-completion".source = ~/.nix-profile/share/bash-completion;

  home.sessionVariables = {
    BASH_COMPLETION_USER_DIR = "${config.xdg.dataHome}/bash-completion";
  };

  programs.bash = {
    enable = true;
    sessionVariables = {
    };
    initExtra = ''        
      PS1="\n\[\e[32m\]bash | \w | \u@\h | \D{%a %d %b %Y %H:%M:%S} \[\e[00m\] \n>> "

      HISTCONTROL=ignorespace:ignoredups:erasedups
      HISTSIZE=10000
      HISTFILESIZE=10000

      shopt -s histappend
      shopt -s autocd 
      shopt -s cdspell 
      shopt -s direxpand
      shopt -s dirspell 
      shopt -s extglob extquote globstar nocaseglob 
      shopt -s checkwinsize
      shopt -s checkjobs

      if [ -e /Users/jayesh/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jayesh/.nix-profile/etc/profile.d/nix.sh; fi

      . ${config.xdg.dataHome}/bash-completion/bash_completion
    '';
  };
}
