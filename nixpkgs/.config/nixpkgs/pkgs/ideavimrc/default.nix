{stdenv, writeText, pkgs}:

let
  configText = ''
    source ~/.config/nvim/init.vim

    set idearefactormode=keep
    set ideajoin
    set clipboard+=ideaput  "Add ideaput to clipboard option to perform a put via the IDE

    nnoremap <space>l :action GotoSymbol<CR>
    nnoremap <space>f :action GotoFile<CR>
    nnoremap <space>a :action GotoAction<CR>
    nnoremap <space>r :action ReformatCode<CR>

    " map <space>r <Action>(RenameElement)
    " map <space>o <Action>(FileStructurePopup)
    " map <space>z <Action>(ToggleDistractionFreeMode)
    " map <space>s <Action>(SelectInProjectView)
    " map <S-Space> <Action>(GotoNextError)

    " Configure emulated plugins
    set commentary
    set surround
  '';

  src = writeText "ideavimrc" configText;

in

stdenv.mkDerivation rec {
  pname = "ideavimrc";
  version = "0.0.1";
  inherit src;
  builder = ./builder.sh;
  buildInputs = [../../build-helpers/create-link.sh];
  HOME = builtins.getEnv "HOME";
}