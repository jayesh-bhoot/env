runtime vimrc/basic.vim
runtime vimrc/autosave.vim
runtime vimrc/gvim.vim

runtime vimrc/vim-plug.vim
call plug#begin('~/.vim/plugged')

" Plug 'vim-airline/vim-airline'
" Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-exchange'
Plug 'itspriddle/vim-shellcheck'

runtime vimrc/fzf.vim
runtime vimrc/vim-lsc.vim

"=== text objects
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'chaoren/vim-wordmotion'
"===

runtime vimrc/clojure.vim

"=== nix
" rnix-lsp does not work without vim-nix.
Plug 'LnL7/vim-nix', {'for': 'nix'}
"===

call plug#end()
