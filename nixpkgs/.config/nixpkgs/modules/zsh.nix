{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
    history = {
      extended = true; # Save timestamp into the history file
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
    sessionVariables = {
      KEYTIMEOUT = 1;  # reduce zsh-vimode's ESC key delay to 0.1s=100ms
      PROMPT = "\n%F{green}%D{%a %d %b %Y %H:%M:%S}%f %F{green}| %F{green}%n@%M%f %F{green}| %F{green}%~%f %F{green}| %F{green}zsh %k\n>>%f ";
    };
    initExtra = ''        
      if [ -e /Users/jayesh/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/jayesh/.nix-profile/etc/profile.d/nix.sh; fi
    '';
  };
}
