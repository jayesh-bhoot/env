{ config, pkgs, lib, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = [
    # pkgs.open-sans      
    # pkgs.roboto      
    pkgs.ubuntu_font_family      
    pkgs.fira      
    pkgs.fira-code      
    pkgs.fira-code-symbols      
    # pkgs.hack-font # horrible zero
    # pkgs.dejavu_fonts # ~ is not curvy enough to be distinguishable from -. – itself is too small.
    # pkgs.roboto-mono # [] are not wide enough. But ~ and - are good.
    pkgs.source-code-pro      
    pkgs.office-code-pro      
    pkgs.courier-prime      
    pkgs.iosevka-bin
    # pkgs.vistafonts  # for consolas
  ];

  xdg.dataFile = if pkgs.stdenv.isLinux then 
  {
    "fonts".source = ./fonts;
  } else { };

  home.activation = if pkgs.stdenv.isDarwin then 
    {
      copyExtraFonts = lib.hm.dag.entryAfter ["writeBoundary"] ''
       $DRY_RUN_CMD rm -rf $VERBOSE_ARG ~/Library/Fonts/HomeManagerExtra
       $DRY_RUN_CMD cp -r $VERBOSE_ARG ${./fonts} ~/Library/Fonts/HomeManagerExtra
       $DRY_RUN_CMD find $VERBOSE_ARG ~/Library/Fonts/HomeManagerExtra -type d -exec chmod 744 {} \;
       $DRY_RUN_CMD find $VERBOSE_ARG ~/Library/Fonts/HomeManagerExtra -type f -exec chmod 644 {} \;
     '';
   } else { };
}
