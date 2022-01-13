# export FZF_CTRL_T_COMMAND='find . -name .git -prune -o -print'
export FZF_DEFAULT_COMMAND='ag --hidden -l -g ""'
export FZF_DEFAULT_OPTS="--exact"

# nix
src=~/.nix-profile/share/fzf/key-bindings.bash; [ -e $src ] && source $src; src=
src=~/.nix-profile/share/fzf/completion.bash; [ -e $src ] && source $src; src=

# Homebrew
# # Setup fzf
# if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
#   export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
# fi
# [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null
# source "/usr/local/opt/fzf/shell/key-bindings.bash"
# export PATH="~/.vim/bundle/fzf/bin:$PATH"

# ArchLinux?
# src=/usr/share/fzf/key-bindings.bash; [ -e $src ] && source $src; src=

# ubuntu
# src=/usr/share/doc/fzf/examples/key-bindings.bash; [ -e $src ] && source $src; src=

# fedora
# src=/usr/share/fzf/shell/key-bindings.bash; [ -e $src ] && source $src; src=

# opensuse
# src=/etc/bash_completion.d/fzf-key-bindings; [ -e $src ] && source $src; src=


