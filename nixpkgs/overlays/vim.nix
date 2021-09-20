self: super:

rec {
  vim-iced = super.callPackage ../pkgs/vim-iced.nix {};
  # vim-iced-compe = super.callPackage ../pkgs/vim-iced-compe.nix {};  # didn't work right away. so not being used anywhere.
  neovim = super.callPackage ../pkgs/neovim.nix {
    inherit self;
    inherit super; 
  };
}
