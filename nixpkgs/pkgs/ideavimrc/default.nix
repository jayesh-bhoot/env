{stdenv, writeText, pkgs}:

let
  configText = ''
    nnoremap <space> <Nop>
    let mapleader = " "

    set idearefactormode=keep
    set ideajoin
    set clipboard+=ideaput  "Add ideaput to clipboard option to perform a put via the IDE

    nnoremap ,s :action GotoSymbol<CR>
    inoremap ,s <esc>:action GotoSymbol<CR>
    nnoremap ,f :action GotoFile<CR>
    inoremap ,f <esc>:action GotoFile<CR>

    nnoremap ,r :action ReformatCode<CR>
    inoremap ,r <esc>:action ReformatCode<CR>

    " nnoremap ,a :action GotoAction<CR>

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
}
