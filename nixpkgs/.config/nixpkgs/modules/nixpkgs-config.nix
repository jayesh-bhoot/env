{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    input-fonts.acceptLicense = true;
  };
}
