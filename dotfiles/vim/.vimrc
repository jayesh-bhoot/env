" Least problematic keys to use as either leader or personal namespace keys are:
" <space>
" comma
" <CR>
" \ (which is default leader)
" <comma> allows the use of the same key bindings as in normal mode, in insert mode,
" because nowhere during editing will I ever type ',<char>'. <space> always follows a <comma>.

filetype plugin indent on
syntax on
packadd! matchit

set incsearch
set path=.,,**
set mouse=nvic
set wildmenu
set smarttab
set shiftround
set autoindent
set backspace=indent,eol,start
set hidden
set ruler
set completeopt=menu,menuone,preview
set wildcharm=<C-z>
set laststatus=2
set guifont=Cascadia\ Code:h17

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'romainl/vim-cool'
Plug 'romainl/vim-devdocs'
Plug 'tommcdo/vim-exchange'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'chaoren/vim-wordmotion'
Plug 'itspriddle/vim-shellcheck'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '40%' }
nnoremap ,f :Files<CR>
nnoremap ,b :Buffers<CR>
nnoremap ,s :WorkspaceSymbols<CR>
nnoremap ,d :DocumentSymbols<CR>
nnoremap ,r :References<CR>
nnoremap ,lb :Diagnostics<CR>
nnoremap ,la :DiagnosticsAll<CR>

Plug 'natebosch/vim-lsc'
" Why not vim-lsp?
" vim-lsp did not work well. For example, while errors are highlighted,
" putting the cursor on the error does not display the error. :LspNextError
" also does not work. I gave up after that. vim-lsc just works.
let g:lsc_server_commands = { 
			\ 'ocaml': 'ocamllsp',
			\ 'nix': 'rnix-lsp',
			\}
let g:lsc_auto_map = v:true

Plug 'LnL7/vim-nix', {'for': 'nix'}

Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}
" Plug 'tami5/vim-iced-compe', {'for': 'clojure'}
let g:iced_enable_default_key_mappings = v:true

call plug#end()

cnoremap <expr> <Tab>   getcmdtype() =~ '[/?]' ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[/?]' ? "<C-t>" : "<S-Tab>"

augroup autosave
	autocmd!
	autocmd CursorHold,CursorHoldI,InsertLeave,FocusLost,BufLeave * silent! wa
augroup END

" various adjustments of the default colorscheme
hi ModeMsg      ctermbg=green     ctermfg=black cterm=NONE
hi StatusLineNC ctermbg=lightgrey                cterm=bold
hi Visual       ctermbg=lightcyan ctermfg=black cterm=bold
