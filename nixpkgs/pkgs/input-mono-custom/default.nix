{stdenv}:

stdenv.mkDerivation rec {
  pname = "input-mono-custom";
  version = "0.0.1";
  src = ./InputMono;
  builder = ./builder.sh;
}
