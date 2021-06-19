{ config, pkgs, ... }:

{
  time.hardwareClockInLocalTime = false;
  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN.UTF-8";
}