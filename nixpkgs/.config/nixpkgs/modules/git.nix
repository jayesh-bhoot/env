{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "Jayesh Bhoot";
    userEmail = "jayesh@bhoot.sh";
  };
}
