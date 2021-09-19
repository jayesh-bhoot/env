{ vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  pname = "vim-iced-compe";
  version = "20201222";
  src = fetchFromGitHub {
    owner = "tami5";
    repo = "vim-iced-compe";
    rev = "20201222";
    sha256 = "1klvq511zc1y8rbjizhc3m0hx3a0ydcjv7wz1s74jx8vnfw24w5n";
  };
  meta.homepage = "https://github.com/tami5/vim-iced-compe";
}
