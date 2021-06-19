{ stdenv, ocaml, opam2nix }:

let
  selection = opam2nix.build {
    inherit ocaml;
    selection = ./opam-selection.nix;
    override = { }: {
      digestif = super: super.overrideAttrs (attrs: {
        preBuildPhases = ["preBuildPhase"];
        preBuildPhase = if stdenv.isLinux then 
          ''
          # `patchShebangs` replaces `#!/usr/bin/env ocaml` with
          # `#!/nix/store/<hash>-ocaml-<version>/bin/ocaml` in `digestif/install/install.ml`.

          echo "This is a Linux system. Patching shebang for ./install/install.ml..."
          patchShebangs ./install/install.ml
          ''
          else 
          ''
          # patchShebangs does not always work on macOS.
          # 
          # macOS does not allow another shell script to play a role as an interpreter.
          # Instead of throwing an error in such a case, the script simply runs under the default shell.
          # So, in our case, macOS would erroneously execute the `install.ml` as a bash script, which will then start throwing syntax errors.
          #
          # The details are described [here](https://github.com/NixOS/nixpkgs/issues/2146#issue-30935650):
          # > This works in linux systems, but does not work on BSD flavored systems like OS X
          # > since they do not allow another shell script to play a role as an interpreter.
          #
          # and [here](https://github.com/NixOS/nixpkgs/issues/2146#issuecomment-43240756):
          # > It's concerned with the fact that scripts cannot be used as an interpreter of other scripts on BSD
          #
          # True enough, `/nix/store/<hash>-ocaml-<version>/bin/ocaml` is a shell script in disguise (wrapper?).
          #
          # ```
          # > head -1 /nix/store/<hash>-ocaml-<version>/bin/ocaml
          # #!/nix/store/<hash>-ocaml-<version>/bin/ocamlrun
          # ```
          # 
          # In any case, `/usr/bin/env` remains available in macOS during `nix-build` anyway.
          # So the package builds in macOS without patching the shebang.

          echo "This is a macOS system. Won't patch shebang for ./install/install.ml..."
          '';
      });
    };
  };
in
selection.dream
