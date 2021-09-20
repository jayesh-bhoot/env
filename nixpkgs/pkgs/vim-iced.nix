{ vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  pname = "vim-iced";
  version = "3.6.2";
  src = fetchFromGitHub {
    owner = "liquidz";
    repo = "vim-iced";
    rev = "3.6.2";
    sha256 = "1klvq511zc1y8rbjizhc3m0hx3a0ydcjv7wz1s74jx8vnfw24w5n";
  };
  meta.homepage = "https://github.com/liquidz/vim-iced";
}
