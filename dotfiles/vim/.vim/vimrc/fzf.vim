Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

let g:fzf_layout = { 'down': '40%' }
nnoremap ,f :Files<CR>
" inoremap ,f <ESC>:Files<CR>
nnoremap ,b :Buffers<CR>
" inoremap ,b <ESC>:Buffers<CR>
nnoremap ,s :WorkspaceSymbols<CR>
" inoremap ,s <ESC>:WorkspaceSymbols<CR>
nnoremap ,d :DocumentSymbols<CR>
" inoremap ,bs <ESC>:DocumentSymbols<CR>
nnoremap ,r :References<CR>
" inoremap ,r <ESC>:References<CR>
nnoremap ,lb :Diagnostics<CR>
nnoremap ,la :DiagnosticsAll<CR>
