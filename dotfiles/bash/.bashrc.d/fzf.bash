# TODO: use if/case to source files based on the OS

export FZF_CTRL_T_COMMAND="find . -path '*/\.git' -prune -o -type f -print -o -type l -print | sed 's:^..::'"
export FZF_DEFAULT_COMMAND="find . -path '*/\.git' -prune -o -type f -print -o -type l -print | sed 's:^..::'"
export FZF_DEFAULT_OPTS="--exact"

# nix
source ~/.nix-profile/share/fzf/key-bindings.bash
source ~/.nix-profile/share/fzf/completion.bash

# ubuntu
# src=/usr/share/doc/fzf/examples/key-bindings.bash; [ -e $src ] && source $src; src=

# fedora
# src=/usr/share/fzf/shell/key-bindings.bash; [ -e $src ] && source $src; src=

# opensuse
# src=/etc/bash_completion.d/fzf-key-bindings; [ -e $src ] && source $src; src=


