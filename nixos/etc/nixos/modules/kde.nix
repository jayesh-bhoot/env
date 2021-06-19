{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  environment.systemPackages = with pkgs; [
    ark
    okular
    gwenview
    transmission-qt
  ];
}

