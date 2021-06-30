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
    silver-searcher      
    jq
    tldr
    rsync

    wget      
    curl      


    openssl      
    cacert      
    
    git      
    nixpkgs-fmt

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

      xdotool
      xclip
      kitty

      firefox
      chromium
      thunderbird

      vscodium
      jetbrains.webstorm      
      jetbrains.idea-community
      
      teams  
    ]
   else 
    [ ])

  ++

  (if pkgs.stdenv.isDarwin then
    [ ]
   else
    [ ]);
}
