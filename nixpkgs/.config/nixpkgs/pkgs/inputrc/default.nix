{stdenv, writeText, pkgs}:

let
  inputrcText = ''
    set bell-style none

    # display all possible matches for an ambiguous pattern at first tab
    set show-all-if-ambiguous on

    set match-hidden-files on

    # ignore case in TAB autocomplete
    set completion-ignore-case on

    # on menu-complete, first display the common prefix, then cycle through the options when hitting TAB
    set menu-complete-display-prefix on

    # set editing-mode vi
    # set keyseq-timeout 100 # reduce the ESC delay from 100ms
    # set keymap vi-insert # Keymaps for when we're in insert (i.e., typing stuff in) mode
    # "jj": vi-movement-mode

    set keymap emacs
    "\C-l": clear-screen
    TAB: menu-complete
    "\e[Z": menu-complete-backward
    "\eg":glob-complete-word
    "\e[6~": menu-complete  # PgDn to cycle forward through the completion options. Alt+n PgDn to Move forward to nth option from the current one.
    "\e[5~": menu-complete-backward  # PgUp to cycle backward through the completion options. Alt+n PgDn to move backward to nth option from the current one.
  '';

  src = writeText "inputrc" inputrcText;

in

stdenv.mkDerivation rec {
  pname = "inputrc";
  version = "0.0.1";
  inherit src;
  builder = ./builder.sh;
  buildInputs = [../../build-helpers/create-link.sh];
  HOME = builtins.getEnv "HOME";
}