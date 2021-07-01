{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bashInteractive_5  # why not bash_5? bashInteractive_5 comes with readline support by default.
    bash-completion
    nix-bash-completions

    parallel
    tree
    htop
    fzf      
    jq
    tldr

    openssl
    cacert

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
  ] 

  ++

  (if pkgs.stdenv.isLinux then
    [
      finger_bsd

      xclip

      firefox
      chromium

      vscodium
      jetbrains.webstorm      
      jetbrains.idea-community
      
      teams  
    ]
   else 
    [ ])

  ++

  (if pkgs.stdenv.isDarwin then
  [ 
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
  ]
   else
    [ ]);
}
