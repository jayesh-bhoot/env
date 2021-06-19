{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    parallel
    tree
    htop
    fzf      
    silver-searcher      
    jq
    tldr
    rsync
    finger_bsd

    wget      
    curl      

    bashInteractive_5  # why not bash_5? bashInteractive_5 comes with readline support by default.
    bash-completion
    nix-bash-completions
    zsh      

    openssl      
    cacert      
    
    git      
    nixpkgs-fmt
    clojure      
    adoptopenjdk-bin      
    nodejs-14_x      

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
