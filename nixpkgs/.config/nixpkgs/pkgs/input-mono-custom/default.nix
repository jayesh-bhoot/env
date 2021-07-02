{stdenv}:

stdenv.mkDerivation rec {
  pname = "input-mono-custom";
  version = "0.0.1";
  src = ./InputMono;
  builder = ./builder.sh;
  buildInputs = [../../build-helpers/create-link.sh];
  XDG_DATA_HOME = "${builtins.getEnv "HOME"}/.local/share";
  HOME = builtins.getEnv "HOME";
  is_darwin = if stdenv.isDarwin then 1 else 0;
}