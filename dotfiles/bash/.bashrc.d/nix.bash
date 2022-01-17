### Nix
# ~/.nix-profile/etc/profile.d/nix.sh probably does not exist for multi-user installation, which has become necessary on M1 Mac.
# source ~/.nix-profile/etc/profile.d/nix.sh
# https://nixos.org/manual/nix/unstable/installation/env-variables.html suggests to source the following (understand `prefix` here: https://discourse.nixos.org/t/nix-bin-not-existing/3700).
source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"


# search for ":\+" in `man bash` to understand ${x:+y}.
# Basically, it means use evaluated y only if x is not null or not unset.
# so ${NIX_PATH:+:$NIX_PATH} evaluates to expanede $NIX_PATH only if NIX_PATH is not null or not unset.
# if NIX_PATH is set, the result is $HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels_root:$NIX_PATH
# else the result is $HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels_root

# Set NIX_PATH for home-manager.
# Nix does not set NIX_PATH on non-NixOS systems.
# Instead, it uses a default search path, which defaults to /nix/var/nix/profiles/per-user/root/channels.
# However, home-manager cannot find it without having defined it in NIX_PATH.
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
# export NIX_PATH=$HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels_root${NIX_PATH:+:$NIX_PATH}
