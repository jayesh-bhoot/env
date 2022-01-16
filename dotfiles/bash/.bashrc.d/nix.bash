### Nix
# ~/.nix-profile/etc/profile.d/nix.sh probably does not exist for multi-user installation, which has become necessary on M1 Mac.
# source ~/.nix-profile/etc/profile.d/nix.sh

source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
export NIX_PATH=$HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels_root

