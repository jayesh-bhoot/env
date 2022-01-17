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
    systems = [ "x86_64-darwin" "aarch64-darwin" "x86_64-linux" ];
    system = "x86_64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    commonPkgs = [
      pkgs.bashInteractive_5 # why not bash_5? bashInteractive_5 comes with readline support by default.
      pkgs.bash-completion
      pkgs.nix-bash-completions

      pkgs.pass
      pkgs.bitwarden-cli

      pkgs.zsh
      pkgs.antigen

      pkgs.parallel
      pkgs.tree
      pkgs.htop
      pkgs.fzf
      pkgs.silver-searcher
      pkgs.jq
      pkgs.tldr
      pkgs.bat

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

      pkgs.vim
      pkgs.rnix-lsp # perhaps automatically installs nixpkgs-fmt
      pkgs.shellcheck
    ];
    nixosPkgs = [
      pkgs.finger_bsd
      pkgs.xclip
      pkgs.firefox
      pkgs.chromium
      pkgs.jetbrains.webstorm
      pkgs.jetbrains.idea-community
      pkgs.teams
    ];
    darwinPkgs = [
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
        # pkgs.open-sans
        # pkgs.roboto      
        # pkgs.hack-font # horrible zero
        # pkgs.dejavu_fonts # ~ is not curvy enough to be distinguishable from -. – itself is too small.
        # pkgs.office-code-pro
        pkgs.ubuntu_font_family      
        pkgs.fira
        pkgs.roboto-mono # [] are not wide enough. But ~ and - are good.
        pkgs.source-code-pro      
        pkgs.courier-prime      
        pkgs.vistafonts  # for consolas
        pkgs.jetbrains-mono
        pkgs.cascadia-code
        pkgs.ibm-plex
        pkgs.iosevka-bin
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
