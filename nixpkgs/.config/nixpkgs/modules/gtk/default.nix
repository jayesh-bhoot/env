{ config, pkgs, ... }:

{
  gtk.gtk3.extraCss = ''
    /* Use https://github.com/GNOME/gtk/blob/master/gtk/theme/Adwaita/gtk-contained.css for reference. */
    .title {
        /* disembolden titles */
        font-weight: normal;
    }
  '';
}
