runtime vimrc/basic.vim
runtime vimrc/autosave.vim
runtime vimrc/gvim.vim
runtime vimrc/vim-plug.vim

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'romainl/vim-cool'
Plug 'romainl/vim-devdocs'
"=== text objects
Plug 'tommcdo/vim-exchange'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'chaoren/vim-wordmotion'
"===
runtime vimrc/fzf.vim
Plug 'itspriddle/vim-shellcheck'
runtime vimrc/vim-lsc.vim
runtime vimrc/clojure.vim
" rnix-lsp does not work without vim-nix.
Plug 'LnL7/vim-nix', {'for': 'nix'}
call plug#end()
