{stdenv, writeText, pkgs}:

# Note on bash completion:
# 
# Official structure:
# 
# 1. $XDG_DATA_HOME/bash-completion/{bash_completion, completions}, where
# 2. `bash-completion/bash_completion` file sets up the auto-completion, and
# 3. `bash-completion/completions` directory houses completion files for all the programs. *Any program intending to provide bash completion is supposed to put its completion files in this directory*.
# 
# One of the places `bash_completion` looks into is the directory configured by `BASH_COMPLETION_USER_DIR`.
# So, to set up, We need the following in `.bashrc`:
# 
# 1. `export BASH_COMPLETION_USER_DIR=$XDG_DATA_HOME/bash-completion`
# 2. `. $XDG_DATA_HOME/bash-completion/bash_completion`
# 
# In Nix, `pkgs.bash_completion` package puts the following files and directories:
# 
# 1. `~/.nix-profile/share/bash-completion/bash_completion`, Which is a symbolic link to the `bash_completion` script installed by `pkgs.bash_completion`
# 2. The content of `~/.nix-profile/share/bash-completion/completions` are symbolic links to:
#    1. the completions installed by `pkgs.bash_completion` in `/nix/store`
#    2. *the completions separately installed by programs like git*
# 3. `~/.nix-profile/etc/profile.d/bash_completion.sh`, which performs a sanity check and sources *the actual file in /nix/store to which `~/.nix-profile/share/bash-completion/bash_completion` also points to*.
# 4. `BASH_COMPLETION_USER_DIR` does not seem to be configured by default.
# 
# So, in Nix, we are supposed to:
# 
# 1. `export BASH_COMPLETION_USER_DIR=~/.nix-profile/share/bash-completion`
# 2. `. ~/.nix-profile/etc/profile.d/bash_completion.sh`.  We could also `. ~/.nix-profile/share/bash-completion/bash_completion` instead, but then we would miss out on the sanity checks performed by the former script.
# 
# This approach is of course not compliant with the official approach of bash_completion. In order to make things compliant, what I did is:
# 
# 1. Create a symbolic link at `$XDG_DATA_HOME/bash-completion`, which points to `~/.nix-profile/share/bash-completion`
# 2. `export BASH_COMPLETION_USER_DIR=$XDG_DATA_HOME/bash-completion`
# 3. `. $XDG_DATA_HOME/bash-completion/bash_completion`

let
  bashConfig = ''
    source ~/.nix-profile/share/bash-completion/completions/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=1
    PS1="\n\[\e[32m\]\u | \w \[\e[00m\] \n=> "

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

    source ${pkgs.bash-completion}/share/bash-completion/bash_completion
    export BASH_COMPLETION_USER_DIR=~/.nix-profile/share/bash-completion
  '';

  nixConfig = ''
    src=~/.nix-profile/etc/profile.d/nix.sh; [ -e $src ] && source $src; src=
  '';

  commonVars = ''
    export EDITOR="vim"
    export VISUAL="vim"
    export DOTNET_CLI_TELEMETRY_OPTOUT=true
    export LC_ALL="en_US.UTF-8"
    export LANG="en_US.UTF-8"
    export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
  '';

  fzfConfig = ''
    source ${pkgs.fzf}/share/fzf/completion.bash
    source ${pkgs.fzf}/share/fzf/key-bindings.bash
    export FZF_CTRL_T_COMMAND='find . -name .git -prune -o -print'
  '';

  neovimConfig = ''
    if command -v nvim &> /dev/null; then
      alias vimdiff="nvim -d"
    fi
  '';

  src = writeText "bashrc" (builtins.concatStringsSep "\n" [bashConfig nixConfig commonVars fzfConfig neovimConfig]);

in

stdenv.mkDerivation rec {
  pname = "bashrc";
  version = "0.0.1";
  inherit src;
  builder = ./builder.sh;
}
