{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [ 
      vim-nix
    ];
    extraConfig = ''
      " Use <space> as leader. There are two solutions:
      " 1. nullify <space> usage, and then assign <space> directly as the leader.
      " nnoremap <SPACE> <Nop>
      " let mapleader=" "
      " However, with the above solution, when `set showcmd` is on,
      " ideavim does not display anything for space in the bottom right command corner.
      " In contrast, neovim displays <20> for space.
      
      " 2. A better solution is to retain '\' as the leader, and map <Space> to <leader>,
      " so that '\' will show up in the command corner when leader is invoked, i.e., <space> or \ is pressed.
      " I don't have any use for the default leader key '\' anyway.
      " Also, I don't have to unmap space first.
      map <Space> <leader>
      
      nnoremap , :
      vnoremap , :

      inoremap jj <Esc>
      
      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q<CR>

      nnoremap gb :ls<CR>:b<Space>

      nnoremap <leader>s :s/
      nnoremap <leader>S :%s/
      vnoremap <leader>s :s/
      vnoremap <leader>S :%s/

      tnoremap <Esc> <C-\><C-n>

      " use j and k to move across the visible, soft-wrapped screen lines, instead of physical lines.
      " this solution also ensures that jumping around using the relative linenumbers keep working.
      " use gj and gk to move across physical lines instead.
      " https://stackoverflow.com/a/21000307/663911
      noremap <expr> k (v:count == 0 ? 'gk' : 'k')
      noremap <expr> j (v:count == 0 ? 'gj' : 'j')

      " Better to retain the default case-sensitive search,
      " and use the escape sequence \c instead for a case-insensitive search.
      " eg: /esc will ignore Esc, but /\cesc or /esc\c will find it.
      " IF ignorecase is true, then \C (capital C) can perform an explicit case-sensitive search.
      " https://stackoverflow.com/a/2287449
      " set ignorecase 
      set incsearch


      set nocompatible

      set showmode
      set showcmd

      set number
      set relativenumber
      
      " this set always uses spaces instead of tabs => no mix of tabs and spaces.
      " check :h tabstop for hints on this set of config
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set smarttab
      set smartindent
      set autoindent

      set mouse=nvic
      
      " always use system clipboard. ^= makes a cross-platform solution.
      set clipboard^=unnamed,unnamedplus

      set scrolloff=1  " keep n lines above/below cursor when scrolling

      map Q gq " Don't use Ex mode, use Q for formatting.

      if has("gui_running")
        set guifont=Consolas:h18
        set linespace=3
      endif
    '';
  };
}
