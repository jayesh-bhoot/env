{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  shellHook = ''
    alias {vi,vim,nvim}='nvim --cmd "set path=.,,nixpkgs/.config"'
  '';
}
