self: super:

let 
  ocamlModulePath = moduleName: ../pkgs/development/ocaml-modules + "/${moduleName}";
in
  {
    ocamlPackages = super.ocaml-ng.ocamlPackages.overrideScope' (
    # elements of pkgs.ocamlPackages must be taken from oself and osuper
    oself: osuper: {
      ojs = super.callPackage (ocamlModulePath "ojs") {
        ocamlPackages = oself;
      };

      gen_js_api = super.callPackage (ocamlModulePath "gen_js_api") {
        ocamlPackages = oself;
      };

      promise_jsoo = super.callPackage (ocamlModulePath "promise_jsoo") {
        ocamlPackages = oself;
      };
    });
  }
