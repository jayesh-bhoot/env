### Nix
# ~/.nix-profile/etc/profile.d/nix.sh probably does not exist for multi-user installation, which has become necessary on M1 Mac.
# source ~/.nix-profile/etc/profile.d/nix.sh
# https://nixos.org/manual/nix/unstable/installation/env-variables.html suggests to source the following (understand `prefix` here: https://discourse.nixos.org/t/nix-bin-not-existing/3700).
# 2022.04.26: I *probably* don't need to source this now that I use flake for NixOS and HM.
# source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

# From https://discourse.nixos.org/t/home-manager-doesnt-seem-to-recognize-sessionvariables/8488/12:
# > home.sessionVariables are defined in a file named hm-session-vars.sh. If you are in a shell provided by a HM module, this file is already sourced. If you are not using a shell provided by a HM module (e.g. shell provided by NixOS) or writing your own HM module for a shell, then you need to source that file yourself to have those sessions variables defined.
# So I need to source this file only if I am using a non-HM-managed shell, but need HM-managed session variables. Thing is I use neither an HM-managed shell nor HM-managed session variables.
# So I should not need to source this file.
# source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Search for ":\+" in `man bash` to understand ${x:+y}.
# Basically, it means use evaluated y only if x is not null or not unset.
# so ${NIX_PATH:+:$NIX_PATH} evaluates to expanede $NIX_PATH only if NIX_PATH is not null or not unset.
# if NIX_PATH is set, the result is $HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels_root:$NIX_PATH
# else the result is $HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels_root

# Set NIX_PATH for home-manager.
# Nix does not set NIX_PATH on non-NixOS systems.
# Instead, it uses a default search path, which defaults to /nix/var/nix/profiles/per-user/root/channels.
# However, home-manager cannot find it without having defined it in NIX_PATH.
# 2022.04.26: NIX_PATH should no longer be necessary now that both NixOS and HomeManager get their config from a flake.
# export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
# export NIX_PATH=$HOME/.nix-defexpr/channels:$HOME/.nix-defexpr/channels_root${NIX_PATH:+:$NIX_PATH}
