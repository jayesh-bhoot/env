{ config, pkgs, ... }:

{
  xdg.enable = true;

  # xdg.configFile."emacs/init.el".source = ../configs/init.el;
  # xdg.configFile."qutebrowser/autoconfig.yml".source = ../configs/qutebrowser.yml;
  # xdg.configFile."sublime-text-3/Packages/User".source = ../configs/sublime-text-3;
  xdg.configFile."VSCodium/User/settings.json".source = ../configs/vscodium/settings.json;
  xdg.configFile."VSCodium/User/keybindings.json".source = ../configs/vscodium/keybindings.json;
  xdg.configFile."ideavim/ideavimrc".source = ../configs/ideavimrc;
  home.file.".inputrc".source = ../configs/inputrc;
  # home.file.".local/share/themes/gnome-shell-theme/gnome-shell/gnome-shell.css".source = ../configs/gnome-shell-theme.css; 

  /* xdg.desktopEntries = {
    anki = {
      name="Anki";
      comment="An intelligent spaced-repetition memory training program";
      genericName="Flashcards";
      exec="/home/jayesh/opt/anki/bin/anki %f";
      tryExec="/home/jayesh/opt/anki/bin/anki";
      icon="/home/jayesh/opt/anki/anki.png";
      categories = ["Education" "Languages" "KDE" "Qt"];
      terminal = false;
      type = "Application";
      mimeType= ["application/x-apkg" "application/x-anki"];
    };

    firefoxNightly = {
      type = "Application";
      name = "Firefox Nightly";
      genericName = "Firefox Nightly";
      comment = "Browse the World Wide Web";
      encoding = "UTF-8";
      icon = "/home/jayesh/opt/firefox/browser/chrome/icons/default/default128.png";
      tryExec = "/home/jayesh/opt/firefox/firefox";
      exec = "/home/jayesh/opt/firefox/firefox --class \"Firefox Nightly Edition\" %U";
      terminal = false;
      categories = ["Network" "WebBrowser"];
    };
  }; */
}
