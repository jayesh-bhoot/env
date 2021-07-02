{stdenv, writeText, pkgs}:

let
  configText = ''
    [user]
      name = Jayesh Bhoot
      email = jayesh@bhoot.sh
    [color "diff"]
      whitespace = bold red reverse
    [diff]
      wserrorhighlight = all
    [pull]
      rebase = false
  '';

  src = writeText "gitconfig" configText;

in

stdenv.mkDerivation rec {
  pname = "gitconfig";
  version = "0.0.1";
  builder = ./builder.sh;
  inherit src;
  buildInputs = [../../build-helpers/create-link.sh];
  HOME = builtins.getEnv "HOME";
}