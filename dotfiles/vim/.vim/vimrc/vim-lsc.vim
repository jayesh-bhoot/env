" Why not use the seemingly better-maintained vim-lsp?
" vim-lsp did not work well. For example, while errors are highlighted,
" putting the cursor on the error does not display the error. :LspNextError
" also does not work. I gave up after that. vim-lsc just works.

Plug 'natebosch/vim-lsc'

let g:lsc_server_commands = { 
            \ 'ocaml': 'ocamllsp',
            \ 'nix': 'rnix-lsp',
            \}

" Use all the defaults (recommended):
let g:lsc_auto_map = v:true