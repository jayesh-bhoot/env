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
    # pkgs.open-sans      
    # pkgs.roboto      
    # pkgs.ubuntu_font_family      
    pkgs.fira
    # pkgs.fira-code      
    # pkgs.fira-code-symbols      
    # pkgs.hack-font # horrible zero
    # pkgs.dejavu_fonts # ~ is not curvy enough to be distinguishable from -. – itself is too small.
    # pkgs.roboto-mono # [] are not wide enough. But ~ and - are good.
    # pkgs.source-code-pro      
    # pkgs.office-code-pro      
    # pkgs.courier-prime      
    # pkgs.iosevka-bin
    # pkgs.vistafonts  # for consolas
    input-mono-custom
  ];

in

  common ++ 
  (if pkgs.stdenv.isLinux then linuxOnly else [ ]) ++ 
  (if pkgs.stdenv.isDarwin then darwinOnly else [ ]) ++
  custom ++
  fonts
