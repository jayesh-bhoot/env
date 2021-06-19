{ ocaml, opam2nix }:

let
  selection = opam2nix.build {
    inherit ocaml;
    selection = ./opam-selection.nix;
  };
in
selection.uuidm
