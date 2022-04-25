# Readme

- Re-installing NixOS on a machine conceptually amounts to creating a new configuration in the flake. So, keeping `stateVersion` in the nixosConfiguration technically is not in conflict, unless we blindly reuse the configuration existing in the flake for that machine.jj

## Tips and hacks

- Solution to error "error: anonymous function at /etc/nixos/configuration.nix:1:1 called with unexpected argument 'specialArgs', at ...": https://unix.stackexchange.com/questions/688810/which-parameters-does-configuration-nix-take

- How various channels map to github branches: https://discourse.nixos.org/t/on-niv-running-on-mac-which-branch-should-i-use-to-update-to-21-11-i-cant-find-release-21-11-darwin-branch-on-nixpkgs/16446/7
