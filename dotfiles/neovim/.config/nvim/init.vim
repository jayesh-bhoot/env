"=== vim
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

""" editing
" nnoremap ,s :s/
" nnoremap ,S :%s/
" vnoremap ,s :'<,'>s/

" I have re-mapped caps lock to escape key for now. Let's see how it works.
" inoremap jj <Esc>
" inoremap ,, <Esc>

set hidden
nnoremap ,w :w<CR>
nnoremap ,q :q<CR>

augroup autosave
    autocmd!
    autocmd CursorHold,CursorHoldI,InsertLeave,FocusLost,BufLeave * silent! wa
augroup END

" always use system clipboard. ^= means *prepend* to the existing value of the clipboard variable.
set clipboard^=unnamed,unnamedplus

set completeopt=menu,menuone,noselect

" enabling this overrides the escape the binding used by FZF to close its pop-up windows
" tnoremap <Esc> <C-\><C-n>  

nnoremap \ :
vnoremap \ :
"====


"=== vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"===

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tommcdo/vim-exchange'

"=== colorscheme
" Plug 'NLKNguyen/papercolor-theme'
" set background=light
" autocmd VimEnter * colorscheme one
"===

"=== fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

let g:fzf_layout = { 'down': '40%' }
nnoremap ,f :Files<CR>
" inoremap ,f <ESC>:Files<CR>
nnoremap ,b :Buffers<CR>
" inoremap ,b <ESC>:Buffers<CR>
nnoremap ,s :WorkspaceSymbols<CR>
" inoremap ,s <ESC>:WorkspaceSymbols<CR>
nnoremap ,bs :DocumentSymbols<CR>
nnoremap ,bs <ESC>:DocumentSymbols<CR>
nnoremap ,r :References<CR>
nnoremap ,r <ESC>:References<CR>
nnoremap ,lb :Diagnostics<CR>
nnoremap ,la :DiagnosticsAll<CR>
"===

"=== lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'gfanto/fzf-lsp.nvim'

function! SetUpLsp()
    lua << EOF
    vim.lsp.set_log_level("debug")

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
end

local function buf_set_option(...)
vim.api.nvim_buf_set_option(bufnr, ...)
end

--Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }

-- mnemonic gs => goto symbol (Decl|Def|Type|Impl|References)
buf_set_keymap('n', 'gsd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'gsD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gst', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', 'gsi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

-- mnemonic cr: change rename
buf_set_keymap('n', 'cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

-- mnemonic gl: go to lapse/locho(next|previous|all)
buf_set_keymap('n', 'gln', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', 'glp', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

-- mnemonic =b: format buffer
buf_set_keymap("n", "=b", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = { "ocamllsp", "rnix", "clojure_lsp" }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
        capabilities = capabilities,
        }
end
EOF
endfunction

function! SetupSnippetCompletion()
    lua << EOF
    local cmp = require'cmp'

    cmp.setup({
    snippet = {
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
    },
mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
sources = cmp.config.sources(
{{ name = 'nvim_lsp' }, { name = 'vsnip' }, }, 
{{ name = 'buffer' }, })
})
EOF
endfunction

autocmd VimEnter * :call SetUpLsp()
autocmd VimEnter * :call SetupSnippetCompletion()
"===

"=== clojure
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}
" Plug 'tami5/vim-iced-compe', {'for': 'clojure'}

let g:iced_enable_default_key_mappings = v:true
"===

"=== nix
Plug 'LnL7/vim-nix', {'for': 'nix'}
"===

"=== text objects
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'chaoren/vim-wordmotion'
"===

call plug#end()
