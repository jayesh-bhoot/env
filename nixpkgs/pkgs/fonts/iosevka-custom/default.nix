{stdenv}:

stdenv.mkDerivation rec {
  pname = "iosevka-custom";
  version = "0.0.1";
  src = ./ttf;
  builder = ./builder.sh;
}
