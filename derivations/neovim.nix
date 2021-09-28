{ self, super }:

let
  general = ''
    " I have decided to use:
    " <space> as the leader key
    " <comma> as the personal namespace key. using <comma> for the personal namespace has a benefit of using the same key bindings even in insert mode, because nowhere during editing will I ever type ',<char>'. <comma> always precedes a <space>. 
    " <CR> to invoke command line mode (:). <CR> is too far away to use as the leader key or as the personal namespace key, but close enough to invoke command line mode.

    nnoremap <space> <Nop>
    let mapleader = " "
    '';
  navigationAndSearch = ''
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

          " keep n lines above/below cursor when scrolling
          set scrolloff=1  

          " Hit `%` on `if` to jump to `else`.
          runtime macros/matchit.vim

          nnoremap ,f :find **/
          nnoremap gb :ls<CR>:b<space>
    '';

    ui = ''
          set noruler
          set nonumber
          set norelativenumber

          set showmode
          set showcmd
          set mouse=nvic
      '';

      formatting = ''
          " https://old.reddit.com/r/vim/wiki/tabstop
          " https://tedlogan.com/techblog3.html
          " https://old.reddit.com/r/vim/comments/1yfdds/confused_about_cin_smartindent_autoindent_etc/cfk0r70/

          " 1 column = 1 space

          " The following configuration ensures that:
          " 1. the width of the tab-character is retained at 8 spaces, so as not to mess with the default configuration.
          set tabstop=8

          " 2. spaces are inserted instead of tab-character when tab-key is pressed. The tab-character itself is still accessible with Ctrl-V<Tab> key sequence in insert mode.
          set expandtab

          " 3. indentation level (the number of columns the cursor moves when one of the tab-key, backspace-key, <<, >> is pressed) is set to 4 columns.
          set softtabstop=4 " for tab-key and backspace-key
          set shiftwidth=4  " for << and >>

          " 4. minimal auto-indentation is sanely configured even in buffers with no associated filetype
          set autoindent

          " 5. vim is configured to detect the filetype of the files you edit and set the appropriate indentation rules automatically.
          filetype plugin indent on

          " 6. smartindent is turned off. smartindent is an old feature that was meant as a "smarter" context-specific companion to plain autoindent. It is now superseded by both cindent and filetype-specific indentexpr so there's no good reason to set it on.
          set nosmartindent

          " 7. backspace-key can erase auto-indentation, line-break, and start of insert (what's this?) respectively
          set backspace=indent,eol,start

          " 8. default simple syntax highlighting is turned on . This is usually reset by a colour scheme.
          syntax on
          set background=light
          colorscheme PaperColor

          " Don't activate ex-mode on Q. Remap Q to formatting the current line.
          map Q gq 
        '';

        editing = ''
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
          '';

            terminalMode = ''
          tnoremap <Esc> <C-\><C-n>
              '';

              commandLineMode = ''
          nnoremap <CR> :
          vnoremap <CR> :
                '';

          vimIcedPlugin = ''
          let g:iced_enable_default_key_mappings = v:true
            '';


              lsp = ''
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

            buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

            buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

            buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

            -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

            -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

            buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
            buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
            buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

            buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
          end

          -- Use a loop to conveniently call 'setup' on multiple servers and
          -- map buffer local keybindings when the language server attaches
          local nvim_lsp = require('lspconfig')
          local servers = { "ocamllsp", "rnix", "clojure_lsp" }
          for _, lsp in ipairs(servers) do
            nvim_lsp[lsp].setup {
              on_attach = on_attach,
              flags = {
                debounce_text_changes = 150,
              },
              capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
            }
          end
          EOF
                '';

                nvimCmp = ''
          lua << EOF
          local cmp = require'cmp'

          cmp.setup({
            snippet = {
              expand = function(args)
                -- For `vsnip` user.
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
              end,
            },
            mapping = {
              ['<C-d>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.close(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            },
            sources = {
              { name = 'nvim_lsp' },

              -- For vsnip user.
              { name = 'vsnip' },

              { name = 'buffer' },
            }
          })
        EOF
                  '';
in
super.neovim.override {
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC =
        general
        + navigationAndSearch
        + ui
        + formatting
        + editing
        + terminalMode
        + commandLineMode
        + vimIcedPlugin
        + lsp
        + nvimCmp;

      packages.myVimPackage = with self.vimPlugins; {
        # loaded on launch
        start = [
          # ui
          papercolor-theme

          vim-fugitive

          # editing
          vim-surround
          vim-commentary
          fzf-vim
          
          # lsp
          nvim-lspconfig

          # autocomplete
          cmp-nvim-lsp
          nvim-cmp
          # snippets
          vim-vsnip
          cmp-vsnip
          vim-vsnip-integ

          # nix
          vim-nix

          # clojure
          vim-sexp
          vim-sexp-mappings-for-regular-people
          self.vim-iced
          # vim-iced-compe  # did not work plug and play. dont want to waste more time. let clojure-lsp handle autocomplete.
        ];

        # manually loadable by calling `:packadd $plugin-name`
        # however, if a Vim plugin has a dependency that is not explicitly listed in
        # opt that dependency will always be added to start to avoid confusion.
        opt = [];

        # To automatically load a plugin when opening a filetype, add vimrc lines like:
        # autocmd FileType php :packadd phpCompletion
      };
    };
  }
