{ config, pkgs, ... }:

{
  users.users.jayesh = {
    isNormalUser = true;
    description = "Jayesh Bhoot";
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
