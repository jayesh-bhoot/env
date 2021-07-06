{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  services.gnome.core-os-services.enable = true;
  services.gnome.core-shell.enable = true;
  services.gnome.core-utilities.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  services.gnome.chrome-gnome-shell.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.gnome-session
    gnome.gnome-terminal
    gnome.gnome-weather
    gnome.gnome-tweak-tool
    gnome.gnome-disk-utility
    gnome.nautilus
    gnome.dconf-editor
    evince
    gnome.gnome-color-manager
    gnome.gnome-calculator
    gnome.gnome-screenshot
    gnome.gnome-themes-extra
    gnome.cheese
    gnome.file-roller
    gnome.gnome-characters
    gnome.gnome-clocks
    gnome.gnome-logs
    gnome.gnome-system-monitor
    gnomeExtensions.gsconnect
    
    transmission-gtk
  ];
}
