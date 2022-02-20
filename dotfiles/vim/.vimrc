" Least problematic keys to use as either leader or personal namespace keys are:
" <space>
" comma
" <CR>
" \ (which is default leader)
" <comma> allows the use of the same key bindings as in normal mode, in insert mode,
" because nowhere during editing will I ever type ',<char>'. <space> always follows a <comma>.

filetype plugin indent on
syntax on

" tl;dr: Use only spaces for indentation, with a tab-key, BS-key, <<, >> using 4 spaces. Leave the tab-byte(=tab-character) alone. 
set tabstop=8  "Set a tab-byte=character to take up 8 visual columns
set expandtab  "Set a tab-keypress to insert space-bytes instead of a tab-byte. With this, tab-byte is never used for indentation.
set softtabstop=4 "Set a tab-keypress or a backspace-keypress to move 4 columns. With expandtab, 4 space-bytes are inserted/removed.
set shiftwidth=4  "Set an << or >> to indent by 4 columns. With expandtab, 4 space-bytes are inserted/removed.
set autoindent
set backspace=indent,eol,start
set incsearch
set mouse=nvic
set wildmenu
set wildcharm=<C-z>
set completeopt-=preview
set completeopt+=popup
set previewpopup=height:10,width:60
set splitbelow
set splitright
set hidden
set ruler
set laststatus=2
set timeout ttimeout timeoutlen=2000 ttimeoutlen=20
set updatetime=1000
silent !mkdir -p ~/.vim/{swapfiles,backupfiles,undofiles} >/dev/null 2>&1
set directory=~/.vim/swapfiles//,.
set backupdir=~/.vim/backupfiles//,.
set undodir=~/.vim/undofiles//,.
set guifont=MonoLisa\ Medium:h16

call plug#begin('~/.vim/plugged')
packadd! matchit
packadd! cfilter
Plug 'andymass/vim-matchup'
Plug 'romainl/vim-cool'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-exchange'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'LnL7/vim-nix'
Plug 'itspriddle/vim-shellcheck'

Plug 'prabirshrestha/vim-lsp'
au User lsp_setup call lsp#register_server({
            \ 'name': 'ocamllsp',
            \ 'cmd': {server_info->['ocamllsp']},
            \ 'allowlist': ['ocaml', 'reason'],
            \ })
au User lsp_setup call lsp#register_server({
            \ 'name': 'rnix-lsp',
            \ 'cmd': {server_info->['rnix-lsp']},
            \ 'allowlist': ['nix'],
            \ })
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
endfunction
augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 500

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
" For Vim 8 (<c-@> corresponds to <c-space>):
imap <c-@> <Plug>(asyncomplete_force_refresh)

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '40%' }
call plug#end()

" Cannot map <CR> because it overrides the 'Press <CR> on an item in quicklist to jump to the
" associated point in the buffer' feature.
" nnoremap <CR> :
nnoremap ,f :Files<CR>
nnoremap ,b :Buffers<CR>
" nnoremap ,f :e **/
" nnoremap ,b :buffers<CR>:buffer<Space>
nmap =ae =ae<C-o>
cnoremap <expr> <Tab>   getcmdtype() =~ '[/?]' ? "<C-g>" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() =~ '[/?]' ? "<C-t>" : "<S-Tab>"

augroup myvimrc
    autocmd!
    autocmd CursorHold,InsertLeave,FocusLost,BufLeave * silent! update %
    autocmd InsertEnter * set cursorline
    autocmd InsertLeave * set nocursorline
augroup END

highlight ModeMsg ctermbg=green ctermfg=black cterm=NONE
highlight StatusLineNC ctermbg=lightgrey cterm=bold
highlight Visual ctermbg=lightcyan ctermfg=black cterm=bold
