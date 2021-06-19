self: super:

rec {
  opam2nix = super.callPackage ../packages/opam2nix {
  };

  dream = super.callPackage ../packages/dream {
    inherit opam2nix;
  };

  uuidm = super.callPackage ../packages/uuidm {
    inherit opam2nix;
  };
}
