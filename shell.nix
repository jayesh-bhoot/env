{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [ stow ];
  shellHook = ''
    alias {vi,vim,nvim}='nvim --cmd "set path=.,,nixpkgs/.config"'
  '';
}
