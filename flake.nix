{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mypkgs.url = "github:jayesh-bhoot/nix-pkgs";
    iosevka-custom.url = "github:jayesh-bhoot/Iosevka";
    input-mono-custom.url = "github:jayesh-bhoot/input-mono-custom";
    # NOTE1: MonoLisa is a private flake: https://github.com/NixOS/nix/issues/3991
    # NOTE2: Beware of master vs main branch. nix by default assumes master.
    monolisa.url = "git+ssh://git@github.com/jayesh-bhoot/MonoLisa";
  };

  outputs = { self, nixpkgs, home-manager, mypkgs, monolisa, iosevka-custom, input-mono-custom }:
    let
      commonPkgs = system:
        let
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
          };
        in
        [
          pkgs.bashInteractive_5 # why not bash_5? bashInteractive_5 comes with readline support by default.
          pkgs.bash-completion
          pkgs.nix-bash-completions

          pkgs.pass
          pkgs.bitwarden-cli

          pkgs.parallel
          pkgs.tree
          pkgs.htop

          pkgs.fzf
          pkgs.jq

          pkgs.rsync
          pkgs.wget
          pkgs.curl
          pkgs.wireshark-cli

          pkgs.git
          pkgs.stow

          pkgs.mpv
          pkgs.ffmpeg-full
          pkgs.imagemagickBig

          pkgs.youtube-dl
          pkgs.transmission

          pkgs.vim

          pkgs.nixpkgs-fmt
          pkgs.rnix-lsp
          pkgs.shellcheck

          pkgs.open-sans
          pkgs.roboto
          pkgs.hack-font # horrible zero
          pkgs.dejavu_fonts # ~ is not curvy enough to be distinguishable from -. – itself is too small.
          pkgs.office-code-pro
          pkgs.ubuntu_font_family
          pkgs.fira
          pkgs.roboto-mono # [] are not wide enough. But ~ and - are good.
          pkgs.source-code-pro
          pkgs.courier-prime
          pkgs.vistafonts # for consolas
          pkgs.jetbrains-mono
          pkgs.cascadia-code
          pkgs.ibm-plex
          pkgs.iosevka-bin
          mypkgs.packages.${system}.fira-code-static
          monolisa.defaultPackage.${system}
          iosevka-custom.defaultPackage.${system}
          input-mono-custom.defaultPackage.${system}
        ];

      nixOsPkgs = system:
        let
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
          };
        in
        [
          pkgs.finger_bsd
          pkgs.xclip
          pkgs.firefox
          pkgs.chromium
          pkgs.jetbrains.webstorm
          pkgs.jetbrains.idea-community
          pkgs.teams
        ];

      darwinPkgs = system:
        let
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
          };
        in
        [
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
    in
    {
      homeConfigurations = {
        # Each configuration is unique to a combination of user, OS, machine.
        # eg., jayesh@MacMini2018 implies username=jayesh, OS=macOS (default OS), machine=MacMini2018, arch=x86_64-darwin
        # eg., jayesh@NixOSVM-MacMini2018 implies username=jayesh, OS=NixOS in VM, machine=MacMini2018, arch=x86_64-linux?
        # eg., jayesh@Jayesh-MacbookProM1? implies username=jayesh, OS=macOS, machine=Jayesh-MacbookProM1?, arch=aarch64-linux
        # eg., jayesh@NixOS-ThinkpadE431 implies username=jayesh, OS=NixOS, machine=ThinkpadE431, arch=x86_64-linux
        # eg., jayesh@FedoraVM-ThinkpadE431 implies username=jayesh, OS=Fedora on VM, machine=ThinkpadE431, arch=x86_64-linux
        "jayesh@MacMini2018.local" = home-manager.lib.homeManagerConfiguration rec {
          system = "x86_64-darwin";
          username = "jayesh";
          homeDirectory = "/Users/${username}";
          configuration = {
            nixpkgs.config.allowUnfree = true;
            home.packages = (commonPkgs system) ++ (darwinPkgs system);
          };
        };

        # jayesh = home-manager.lib.homeManagerConfiguration rec {
        #   inherit system;
        #   username = "jayesh";
        #   homeDirectory = "/Users/${username}";
        #   configuration = {
        #     nixpkgs.config.allowUnfree = true;
        #     home.packages =
        #       commonPkgs
        #       ++ darwinPkgs
        #       ++ fontPkgs;
        #     };
        #   };
      };
    };
}
