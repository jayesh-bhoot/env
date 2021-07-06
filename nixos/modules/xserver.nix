{ config, pkgs, ... }:

{
  services.xserver.layout = "us";  # Configure keymap in X11
  services.xserver.libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.enable = true;

  imports = [
    ./gnome.nix
    # ./kde.nix
  ];
}

