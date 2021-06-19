{ stdenv, ocaml, opam2nix }:

let
  selection = opam2nix.build {
    inherit ocaml;
    selection = ./opam-selection.nix;
    override = { }: {
      digestif = super: super.overrideAttrs (attrs: {
        # `patchShebangs` replaces `#!/usr/bin/env ocaml` with
        # `#!/nix/store/<hash>-ocaml-<version>/bin/ocaml` in `digestif/install/install.ml`.
        #
        # `stdenv.isLinux` conditional needs to be added to avoid patching the shebang on macos, because:
        # 
        # 1. macOS either doesn't recognize or allow the patched shebang to work.
        #    It erroneously executes the `install.ml` as a bash script instead.
        #    I suspect the reason is as described [here](https://github.com/NixOS/nixpkgs/issues/2146#issue-30935650):
        #    > This works in linux systems, but does not work on BSD flavored systems like OS X
        #    > since they do not allow another shell script to play a role as an interpreter.
        #    or [here](https://github.com/NixOS/nixpkgs/issues/2146#issuecomment-43240756):
        #    > It's concerned with the fact that scripts cannot be used as an interpreter of other scripts on BSD
        #    True enough, `/nix/store/<hash>-ocaml-<version>/bin/ocaml` is a shell script in disguise (wrapper?).
        #    `head -1 /nix/store/<hash>-ocaml-<version>/bin/ocaml` gives:
        #    `#!/nix/store/<hash>-ocaml-<version>/bin/ocamlrun`.
        # 
        # 2. `/usr/bin/env` remains available in macOS during `nix-build` anyway.
        #    So the package builds in macOS without patching the shebang.
        preBuildPhases = ["preBuildPhase"];
        preBuildPhase = if stdenv.isLinux then 
          ''
          patchShebangs ./install/install.ml
          ''
          else "";
      });
    };
  };
in
selection.dream
