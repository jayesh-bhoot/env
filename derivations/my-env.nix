{ pkgs }:

let 
configPkgs = {
        bashrc = pkgs.callPackage ./pkgs/bashrc {};
        inputrc = pkgs.callPackage ./pkgs/inputrc {};
        ideavimrc = pkgs.callPackage ./pkgs/ideavimrc {};
        gitconfig = pkgs.callPackage ./pkgs/gitconfig {};
        # neovim = pkgs.callPackage ../pkgs/neovim.nix {
        #   inherit self;
        #   inherit super;
        # };
      };
      commonPkgs = [
        pkgs.bashInteractive_5 # why not bash_5? bashInteractive_5 comes with readline support by default.
        # (pkgs.hiPrio pkgs.bash-completion)
        # (pkgs.hiPrio pkgs.nix-bash-completions)

        pkgs.parallel
        pkgs.tree
        pkgs.htop
        pkgs.fzf
        pkgs.jq
        pkgs.tldr

        pkgs.rsync
        pkgs.wget
        pkgs.curl

        pkgs.git

        pkgs.mpv
        # pkgs.ffmpeg-full # does not build on Silicon M1
        pkgs.imagemagickBig

        pkgs.youtube-dl
        # pkgs.transmission # does not build on Silicon M1

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
        pkgs.fira
        # fira-code      
        # fira-code-static
        # hack-font # horrible zero
        # dejavu_fonts # ~ is not curvy enough to be distinguishable from -. – itself is too small.
        # roboto-mono # [] are not wide enough. But ~ and - are good.
        # source-code-pro      
        # office-code-pro      
        # courier-prime      
        # vistafonts  # for consolas
        pkgs.jetbrains-mono
        mypkgs.packages.${system}.iosevka-custom
        # input-mono-custom
      ];
      customPkgs = [
        configPkgs.bashrc
        configPkgs.inputrc
        configPkgs.ideavimrc
        # got conflict error (with a /nix/store/<hash>-git-<ver>/etc/gitconfig) without hiPrio
        # solution suggested at: https://discourse.nixos.org/t/how-to-deal-with-conflicting-packages/12505/6?u=jayesh.bhoot
        (pkgs.hiPrio configPkgs.gitconfig)
      ];
in
pkgs.buildEnv {
        defaultPackage.${system} = pkgs.buildEnv {
          name = "my-env";
          paths =
            commonPkgs
            ++ (if pkgs.stdenv.isLinux then linuxOnlyPkgs else [])
            ++ (if pkgs.stdenv.isDarwin then darwinOnlyPkgs else [])
            ++ fontPkgs
            ++ customPkgs;
        };
      };

