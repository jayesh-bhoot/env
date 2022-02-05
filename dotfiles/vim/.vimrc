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

" tl;dr: Use only spaces for indentation, with a tab-key, BS-key, <<, >> using 4 spaces. Leave the tab-byte(=tab-character) alone. 
set tabstop=8  "Set a tab-byte=character to take up 8 visual columns
set expandtab  "Set a tab-keypress to insert space-bytes instead of a tab-byte. With this, tab-byte is never used for indentation.
set softtabstop=4 "Set a tab-keypress or a backspace-keypress to move 4 columns. With expandtab, 4 space-bytes are inserted/removed.
set shiftwidth=4  "Set an << or >> to indent by 4 columns. With expandtab, 4 space-bytes are inserted/removed.

set autoindent
set backspace=indent,eol,start
set incsearch
set path=.,,**
set mouse=nvic
set wildmenu
set completeopt=menu,menuone,preview
set wildcharm=<C-z>
set hidden
set ruler
set laststatus=2
set guifont=Cascadia\ Code:h17

call plug#begin('~/.vim/plugged')
Plug 'romainl/vim-cool'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'LnL7/vim-nix'
Plug 'itspriddle/vim-shellcheck'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'liquidz/vim-iced'
let g:iced_enable_default_key_mappings = v:true

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
call plug#end()

cnoremap <expr> <Tab>   getcmdtype() =~ '[/?]' ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[/?]' ? "<C-t>" : "<S-Tab>"

augroup myvimrc
    autocmd!
    autocmd CursorHold,CursorHoldI,InsertLeave,FocusLost,BufLeave * silent! wa
    autocmd InsertEnter * set cursorline
    autocmd InsertLeave * set nocursorline
augroup END

highlight ModeMsg ctermbg=green ctermfg=black cterm=NONE
highlight StatusLineNC ctermbg=lightgrey cterm=bold
highlight Visual ctermbg=lightcyan ctermfg=black cterm=bold
highlight Cursorline ctermbg=lightred ctermfg=black cterm=NONE

