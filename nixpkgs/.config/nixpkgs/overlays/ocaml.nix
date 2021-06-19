self: super:

rec {
  opam2nix = super.callPackage ../pkgs/opam2nix {
  };

  dream = super.callPackage ../pkgs/dream {
    inherit opam2nix;
  };

  uuidm = super.callPackage ../pkgs/uuidm {
    inherit opam2nix;
  };
}
