### zsh
autoload -Uz compinit
compinit
HISTSIZE="10000"
SAVEHIST="10000"
HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt appendhistory
setopt autocd
setopt extendedglob nomatch
bindkey -v
export KEYTIMEOUT=1  # reduce ESC key delay to 0.1s=100ms
unsetopt beep
NEWLINE=$'\n'; PROMPT="%F{green}zsh | %n | %~ %k${NEWLINE}>%f ";

### plugins
source ~/.nix-profile/share/antigen/antigen.zsh
# antigen use oh-my-zsh
# antigen bundle zsh-users/zsh-completions
# antigen bundle spwhitt/nix-zsh-completions.git
# antigen bundle chisui/zsh-nix-shell
antigen bundle fzf
# antigen bundle git
# antigen bundle ag 
# antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

### editors
export EDITOR="vim"
export VISUAL="vim"

### locale
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

### ssl
# export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt

### .NET
export DOTNET_CLI_TELEMETRY_OPTOUT=true

### Nix
src=$HOME/.nix-profile/etc/profile.d/nix.sh; [ -e $src ] && source $src; src=
# export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
export NIX_PATH=$HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels_root
source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# prompt_nix_shell_setup  # prefix prompt by [nix-shell] inside a nix-shell github.com/spwhitt/nix-zsh-completions
 
