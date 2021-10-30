{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/1f06456eabe9f768f87a26d3ff8b2dc14eb4046d";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mypkgs.url = "github:jayesh-bhoot/nix-pkgs/main";
  };

  outputs = { self, nixpkgs, home-manager, mypkgs }:
    let
      system = "x86_64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          # mypkgs.overlays.dotfiles
          mypkgs.overlays.fonts 
          # mypkgs.overlays.ocaml
          # mypkgs.overlays.vim
        ];
        config.allowUnfree = true;
      };
      commonPkgs = [
        pkgs.bashInteractive_5 # why not bash_5? bashInteractive_5 comes with readline support by default.
        pkgs.bash-completion
        pkgs.nix-bash-completions

        pkgs.zsh
	pkgs.antigen

        pkgs.parallel
        pkgs.tree
        pkgs.htop
        pkgs.fzf
	pkgs.silver-searcher
        pkgs.jq
        pkgs.tldr

        pkgs.rsync
        pkgs.wget
        pkgs.curl

        pkgs.git
        pkgs.stow

        pkgs.mpv
        pkgs.ffmpeg-full
        pkgs.imagemagickBig

        pkgs.youtube-dl
        pkgs.transmission

        pkgs.wireshark-cli

        pkgs.neovim
        pkgs.rnix-lsp # perhaps automatically installs nixpkgs-fmt
      ];
      linuxOnlyPkgs = [
        pkgs.finger_bsd

        pkgs.xclip

        pkgs.firefox
        pkgs.chromium

        pkgs.vscodium
        pkgs.jetbrains.webstorm
        pkgs.jetbrains.idea-community

        pkgs.teams
      ];
      darwinOnlyPkgs = [
        pkgs.coreutils-full
        pkgs.findutils
        pkgs.diffutils
        pkgs.binutils
        pkgs.inetutils

        pkgs.gnugrep
        pkgs.gnused
        pkgs.gawkInteractive

        pkgs.readline
        pkgs.bc
        pkgs.gzip
        pkgs.gnutar
        pkgs.ncurses
        pkgs.less
        pkgs.more
        pkgs.gnupatch
        pkgs.time
        pkgs.which
        pkgs.texinfo
        pkgs.man
        pkgs.man-pages
      ];
      fontPkgs = [
        # open-sans
        # roboto      
        # ubuntu_font_family      
        pkgs.fira-code-static
        # hack-font # horrible zero
        # dejavu_fonts # ~ is not curvy enough to be distinguishable from -. – itself is too small.
        # roboto-mono # [] are not wide enough. But ~ and - are good.
        # source-code-pro      
        # office-code-pro      
        # courier-prime      
        # vistafonts  # for consolas
        pkgs.jetbrains-mono
        # pkgs.iosevka-custom
        # input-mono-custom
      ];
      dotfiles = [
        # pkgs.bashrc
        # pkgs.inputrc
        # pkgs.ideavimrc
        # got conflict error (with a /nix/store/<hash>-git-<ver>/etc/gitconfig) without hiPrio
        # solution suggested at: https://discourse.nixos.org/t/how-to-deal-with-conflicting-packages/12505/6?u=jayesh.bhoot
        # (pkgs.hiPrio pkgs.gitconfig)
      ];
    in
      {
    homeConfigurations = {
      jayesh = home-manager.lib.homeManagerConfiguration rec {
        inherit system;
        username = "jayesh";
        homeDirectory = "/Users/${username}";
        configuration = {
          nixpkgs.config.allowUnfree = true;
          home.packages =             
            commonPkgs
            ++ darwinOnlyPkgs
            ++ fontPkgs
            ++ dotfiles;
        };
      };
    };
      };
}
