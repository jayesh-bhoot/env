export EDITOR="vim"
export VISUAL="vim"
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

src=~/.nix-profile/etc/profile.d/nix.sh; [ -e $src ] && source $src; src=
