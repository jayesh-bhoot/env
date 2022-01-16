" I have decided to use:
" <space> as the leader key
" <comma> as the personal namespace key. using <comma> for the personal namespace has a benefit of using the same key bindings even in insert mode, because nowhere during editing will I ever type ',<char>'. <comma> always precedes a <space>.
" <CR> to invoke command line mode (:). <CR> is too far away to use as the leader key or as the personal namespace key, but close enough to invoke command line mode.
nnoremap <space> <Nop>
let mapleader = " "

" use j and k to move across the visible, soft-wrapped screen lines, instead of physical lines.
" this solution also ensures that jumping around using the relative linenumbers keep working.
" use gj and gk to move across physical lines instead.
" https://stackoverflow.com/a/21000307/663911
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Retain the default case-sensitive search.
" Use the escape sequence \c for a case-insensitive search.
" eg: /esc will ignore Esc, but /\cesc or /esc\c will find it.
" IF ignorecase is true, then \C (capital C) can perform an explicit case-sensitive search.
" https://stackoverflow.com/a/2287449
set noignorecase

set incsearch
set wildcharm=<C-z>
cnoremap <expr> <Tab>   getcmdtype() =~ '[/?]' ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[/?]' ? "<C-t>" : "<S-Tab>"

" keep n lines above/below cursor when scrolling
set scrolloff=2

" Hit `%` on `if` to jump to `else`.
runtime macros/matchit.vim

set noruler
set nonumber
set norelativenumber
set showmode
set showcmd
set mouse=nvic

" https://old.reddit.com/r/vim/wiki/tabstop
" https://tedlogan.com/techblog3.html
" https://old.reddit.com/r/vim/comments/1yfdds/confused_about_cin_smartindent_autoindent_etc/cfk0r70/
" 1 column = 1 space
" The following configuration ensures that:
"
" 1. the width of the tab-character is retained at 8 spaces, so as not to mess with the default configuration.
set tabstop=8

" 2. spaces are inserted instead of tab-character when tab-key is pressed. The tab-character itfinal is still accessible with Ctrl-V<Tab> key sequence in insert mode.
set expandtab

" 3. indentation level (the number of columns the cursor moves when one of the tab-key, backspace-key, <<, >> is pressed) is set to 4 columns
set softtabstop=4 " for tab-key and backspace-key
set shiftwidth=4  " for << and >>

" 4. minimal auto-indentation is sanely configured even in buffers with no associated filetype
set autoindent

" 5. vim is configured to detect the filetype of the files you edit and set the appropriate indentation rules automatically.
filetype plugin indent on

" 6. smartindent is turned off. smartindent is an old feature that was meant as a "smarter" context-specific companion to plain autoindent. It is now prevseded by both cindent and filetype-specific indentexpr so there's no good reason to set it on.
set nosmartindent

" 7. backspace-key can erase auto-indentation, line-break, and start of insert (what's this?) respectively
set backspace=indent,eol,start

" 8. default simple syntax highlighting is turned on . This is usually reset by a colour scheme.
syntax on

" Don't activate ex-mode on Q. Remap Q to formatting the current line.
map Q gq

" nnoremap ,s :s/
" nnoremap ,S :%s/
" vnoremap ,s :'<,'>s/

" Another option is to remap CapsLock to Escape key. Currently, Esc " still feels better.
" inoremap jj <Esc>
" inoremap ,, <Esc>

set hidden
nnoremap ,w :w<CR>
nnoremap ,q :q<CR>

" always use system clipboard. ^= means *prepend* to the existing value of the clipboard variable.
set clipboard^=unnamed,unnamedplus

set completeopt=menu,menuone,noselect

" enabling this overrides the escape the binding used by FZF to close its pop-up windows
" tnoremap <Esc> <C-\><C-n>  

nnoremap \ :
vnoremap \ :
