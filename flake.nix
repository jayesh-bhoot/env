{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NOTE1: MonoLisa is a private flake: https://github.com/NixOS/nix/issues/3991
    # NOTE2: Beware of master vs main branch. nix by default assumes master.
    monolisa.url = "git+ssh://git@github.com/jayesh-bhoot/MonoLisa";
  };

  outputs = { self, nixpkgs, home-manager, monolisa }:
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
          pkgs.direnv
          pkgs.nix-direnv

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
          pkgs.ffmpeg
          pkgs.imagemagickBig

          pkgs.youtube-dl
          pkgs.aria

          pkgs.vim
	  pkgs.nano

          pkgs.nixpkgs-fmt
          pkgs.rnix-lsp
          pkgs.shellcheck

          pkgs.roboto
          pkgs.fira
          pkgs.roboto-mono # [] are not wide enough. But ~ and - are good.
          pkgs.source-code-pro
          pkgs.cascadia-code
          monolisa.defaultPackage.${system}
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
          pkgs.inetutils
          # Don't install binutils.
          # binutils provide building, compiling, linking,and binary utilities, not the command-line utilities as the other packages. 
          # Also, clang, ld, etc., provided by nix binutils somehow almost never work with errors like 'ld: symbol not found for architecture'
          # pkgs.binutils 

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
        "jayesh@Mac-Mini-2018.local" = home-manager.lib.homeManagerConfiguration rec {
          system = "x86_64-darwin";
          username = "jayesh";
          homeDirectory = "/Users/${username}";
          configuration = {
            nixpkgs.config.allowUnfree = true;
            home.packages = (commonPkgs system) ++ (darwinPkgs system);
          };
        };

        "jayesh@Jayeshs-Macbook-Pro-13-M1-2020.local" = home-manager.lib.homeManagerConfiguration rec {
          system = "aarch64-darwin";
          username = "jayesh";
          homeDirectory = "/Users/${username}";
          configuration = {
            nixpkgs.config.allowUnfree = true;
            home.packages = (commonPkgs system) ++ (darwinPkgs system);
          };
        };
      };
    };
}
