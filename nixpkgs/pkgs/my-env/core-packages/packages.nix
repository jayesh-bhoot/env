pkgs: 

with pkgs; 

let
  common = [
    bashInteractive_5  # why not bash_5? bashInteractive_5 comes with readline support by default.
    bash-completion
    nix-bash-completions

    parallel
    tree
    htop
    fzf      
    jq
    tldr

    rsync
    wget      
    curl      

    git

    mpv
    ffmpeg-full
    imagemagickBig

    youtube-dl
    transmission

    wireshark-cli

    neovim
     
    rnix-lsp
    nixpkgs-fmt

    watson
  ];

  linuxOnly = [
    finger_bsd

    xclip

    firefox
    chromium

    vscodium
    jetbrains.webstorm      
    jetbrains.idea-community

    teams  
  ];

  darwinOnly = [ 
    coreutils-full
    findutils
    diffutils
    binutils
    inetutils

    gnugrep
    gnused
    gawkInteractive

    readline
    bc
    gzip
    gnutar
    ncurses
    less
    more
    gnupatch
    time
    which
    texinfo
    man
    man-pages
  ];

  custom = [
    bashrc
    inputrc
    ideavimrc
    # got conflict error (with a /nix/store/<hash>-git-<ver>/etc/gitconfig) without hiPrio
    # solution suggested at: https://discourse.nixos.org/t/how-to-deal-with-conflicting-packages/12505/6?u=jayesh.bhoot
    (hiPrio gitconfig)
  ];

  fonts = [
    rubik
    # open-sans      
    # roboto      
    # ubuntu_font_family      
    fira
    fira-code-static
    # fira-code      
    # hack-font # horrible zero
    # dejavu_fonts # ~ is not curvy enough to be distinguishable from -. – itself is too small.
    # roboto-mono # [] are not wide enough. But ~ and - are good.
    source-code-pro      
    # office-code-pro      
    # courier-prime      
    iosevka-bin
    # vistafonts  # for consolas
    input-mono-custom
  ];

in

  common ++ 
  (if pkgs.stdenv.isLinux then linuxOnly else [ ]) ++ 
  (if pkgs.stdenv.isDarwin then darwinOnly else [ ]) ++
  custom ++
  fonts
