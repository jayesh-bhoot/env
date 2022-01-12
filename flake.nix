{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mypkgs.url = "github:jayesh-bhoot/nix-pkgs";

    # NOTE1: MonoLisa is a private flake: https://github.com/NixOS/nix/issues/3991
    # NOTE2: Beware of master vs main branch. nix by default assumes master.
    monolisa.url = "git+ssh://git@github.com/jayesh-bhoot/MonoLisa";

    iosevka-custom.url = "github:jayesh-bhoot/Iosevka";
    input-mono-custom.url = "github:jayesh-bhoot/input-mono-custom";
  };

  outputs = { self, nixpkgs, home-manager, mypkgs, monolisa, iosevka-custom, input-mono-custom }:
  let
    system = "x86_64-darwin";
    commonPkgs = [
      nixpkgs.legacyPackages.${system}.bashInteractive_5 # why not bash_5? bashInteractive_5 comes with readline support by default.
      nixpkgs.legacyPackages.${system}.bash-completion
      nixpkgs.legacyPackages.${system}.nix-bash-completions

      nixpkgs.legacyPackages.${system}.pass
      nixpkgs.legacyPackages.${system}.bitwarden-cli

      nixpkgs.legacyPackages.${system}.zsh
      nixpkgs.legacyPackages.${system}.antigen

      nixpkgs.legacyPackages.${system}.parallel
      nixpkgs.legacyPackages.${system}.tree
      nixpkgs.legacyPackages.${system}.htop
      nixpkgs.legacyPackages.${system}.fzf
      nixpkgs.legacyPackages.${system}.silver-searcher
      nixpkgs.legacyPackages.${system}.jq
      nixpkgs.legacyPackages.${system}.tldr
      nixpkgs.legacyPackages.${system}.bat

      nixpkgs.legacyPackages.${system}.rsync
      nixpkgs.legacyPackages.${system}.wget
      nixpkgs.legacyPackages.${system}.curl

      nixpkgs.legacyPackages.${system}.git
      nixpkgs.legacyPackages.${system}.stow

      nixpkgs.legacyPackages.${system}.mpv
      nixpkgs.legacyPackages.${system}.ffmpeg-full
      nixpkgs.legacyPackages.${system}.imagemagickBig

      nixpkgs.legacyPackages.${system}.youtube-dl
      nixpkgs.legacyPackages.${system}.transmission

      nixpkgs.legacyPackages.${system}.wireshark-cli

      nixpkgs.legacyPackages.${system}.vim
      mypkgs.packages.${system}.neovim
      nixpkgs.legacyPackages.${system}.rnix-lsp # perhaps automatically installs nixpkgs-fmt
    ];
    nixosPkgs = [
      nixpkgs.legacyPackages.${system}.finger_bsd
      nixpkgs.legacyPackages.${system}.xclip
      nixpkgs.legacyPackages.${system}.firefox
      nixpkgs.legacyPackages.${system}.chromium
      nixpkgs.legacyPackages.${system}.jetbrains.webstorm
      nixpkgs.legacyPackages.${system}.jetbrains.idea-community
      nixpkgs.legacyPackages.${system}.teams
    ];
    darwinPkgs = [
      nixpkgs.legacyPackages.${system}.coreutils-full
      nixpkgs.legacyPackages.${system}.findutils
      nixpkgs.legacyPackages.${system}.diffutils
      nixpkgs.legacyPackages.${system}.binutils
      nixpkgs.legacyPackages.${system}.inetutils

      nixpkgs.legacyPackages.${system}.gnugrep
      nixpkgs.legacyPackages.${system}.gnused
      nixpkgs.legacyPackages.${system}.gawkInteractive

      nixpkgs.legacyPackages.${system}.readline
      nixpkgs.legacyPackages.${system}.bc
      nixpkgs.legacyPackages.${system}.gzip
      nixpkgs.legacyPackages.${system}.gnutar
      nixpkgs.legacyPackages.${system}.ncurses
      nixpkgs.legacyPackages.${system}.less
      nixpkgs.legacyPackages.${system}.more
      nixpkgs.legacyPackages.${system}.gnupatch
      nixpkgs.legacyPackages.${system}.time
      nixpkgs.legacyPackages.${system}.which
      nixpkgs.legacyPackages.${system}.texinfo
      nixpkgs.legacyPackages.${system}.man
      nixpkgs.legacyPackages.${system}.man-pages
    ];
    fontPkgs = [
        # nixpkgs.legacyPackages.${system}.open-sans
        # nixpkgs.legacyPackages.${system}.roboto      
        # nixpkgs.legacyPackages.${system}.hack-font # horrible zero
        # nixpkgs.legacyPackages.${system}.dejavu_fonts # ~ is not curvy enough to be distinguishable from -. – itself is too small.
        # nixpkgs.legacyPackages.${system}.office-code-pro
        nixpkgs.legacyPackages.${system}.ubuntu_font_family      
        nixpkgs.legacyPackages.${system}.fira
        nixpkgs.legacyPackages.${system}.roboto-mono # [] are not wide enough. But ~ and - are good.
        nixpkgs.legacyPackages.${system}.source-code-pro      
        nixpkgs.legacyPackages.${system}.courier-prime      
        nixpkgs.legacyPackages.${system}.vistafonts  # for consolas
        nixpkgs.legacyPackages.${system}.jetbrains-mono
        nixpkgs.legacyPackages.${system}.cascadia-code
        nixpkgs.legacyPackages.${system}.ibm-plex
        nixpkgs.legacyPackages.${system}.iosevka-bin
        # mypkgs.packages.${system}.fira-code-static
        monolisa.defaultPackage.${system}
        iosevka-custom.defaultPackage.${system}
        input-mono-custom.defaultPackage.${system}
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
            ++ darwinPkgs
            ++ fontPkgs;
          };
        };
      };
    };
  }
