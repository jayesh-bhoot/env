{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./modules/networking.nix
      ./modules/bluetooth.nix
      ./modules/sound.nix
      ./modules/locale-time.nix
      ./modules/console.nix
      ./modules/users.nix
      ./modules/xserver.nix
      ./modules/current-package-list.nix
    ];

  services.printing.enable = true;
  services.sshd.enable = true;
}

