{ config, pkgs, ... }:

# https://github.com/nix-community/home-manager/blob/master/modules/programs/vim.nix
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ ];
    extraConfig = ''
      " Better to retain the default case-sensitive search,
      " and use the escape sequence \c instead for a case-insensitive search.
      " eg: /esc will ignore Esc, but /\cesc or /esc\c will find it.
      " IF ignorecase is true, then \C (capital C) can perform an explicit case-sensitive search.
      " https://stackoverflow.com/a/2287449
      " set ignorecase 

      set nocp
      set showcmd

      set relativenumber
      set number
      
      " this set always uses spaces instead of tabs => no mix of tabs and spaces.
      " check :h tabstop for hints on this set of config
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set smarttab
      set smartindent
      set autoindent

      set mouse=nvic
      set dictionary+=/usr/share/dict/words
      
      " always use system clipboard. ^= makes a cross-platform solution.
      set clipboard^=unnamed,unnamedplus

      " use j and k to move across the visible, soft-wrapped screen lines, instead of physical lines.
      " this solution also ensures that jumping around using the relative linenumbers keep working.
      " use gj and gk to move across physical lines instead.
      " https://stackoverflow.com/a/21000307/663911
      noremap <expr> k (v:count == 0 ? 'gk' : 'k')
      noremap <expr> j (v:count == 0 ? 'gj' : 'j')
      inoremap jj <Esc>
      nnoremap <Space> :
      nnoremap ,w :w<CR>
      nnoremap ,q :q<CR>
      nnoremap gb :ls<CR>:b<Space>
      tnoremap <Esc> <C-\><C-n>

      if has("gui_running")
        set guifont=Consolas:h18
        set linespace=3
      endif
    '';
  };
}
