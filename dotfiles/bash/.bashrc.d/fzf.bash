# TODO: use if/case to source files based on the OS

# `find . [test action] -operator [test action]` is used as a convention to keep the command readable.
# This is why `-name '*.swp' -prune` is used instead of `! -name '*.swp' -a (rest of it)` even if *.swp is not a dir.
export {FZF_DEFAULT_COMMAND,FZF_CTRL_T_COMMAND}="find . -name '*.swp' -prune -o -path '*/\.git' -prune -o -type f -print -o -type l -print | sed 's:^..::'"
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


