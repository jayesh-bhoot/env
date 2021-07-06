{ config, pkgs, lib, ... }:

# Thanks to: https://old.reddit.com/r/NixOS/comments/fsummx/how_to_list_all_installed_packages_on_nixos/fm45htj/
{
  environment.etc."current-system-packages".text = let
    packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
    formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
    formatted;
}

