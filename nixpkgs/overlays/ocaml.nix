self: super:

{
  ocamlPackages = super.ocaml-ng.ocamlPackages.overrideScope' (
  # elements of pkgs.ocamlPackages must be taken from oself and osuper
  oself: osuper: {
    ojs = super.callPackage ../pkgs/ojs.nix {
      ocamlPackages = oself;
    };

    gen_js_api = super.callPackage ../pkgs/gen_js_api.nix {
      ocamlPackages = oself;
    };

    promise_jsoo = super.callPackage ../pkgs/promise_jsoo.nix {
      ocamlPackages = oself;
    };
  });
}
