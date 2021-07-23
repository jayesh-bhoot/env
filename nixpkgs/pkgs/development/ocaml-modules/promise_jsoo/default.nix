{ lib, fetchurl, ocamlPackages }:

let
  owner = "mnxn";
in
  ocamlPackages.buildDunePackage rec {
    pname = "promise_jsoo";
    version = "0.3.1";

    useDune2 = true;

    src = fetchurl {
      url = "https://github.com/${owner}/${pname}/releases/download/v${version}/${pname}-v${version}.tbz";
      sha256 = "00pjnsbv0yv3hhxbbl8dsljgr95kjgi9w8j1x46gjyxg9zayrxzl";
    };

    buildInputs = [
      ocamlPackages.js_of_ocaml
      ocamlPackages.ppxlib
      ocamlPackages.js_of_ocaml-ppx
      ocamlPackages.gen_js_api
    ];

    meta = with lib; {
      homepage = "https://github.com/${owner}/${pname}";
      description = "Js_of_ocaml bindings to JS Promises with supplemental functions";
      license = licenses.mit;
    # maintainers = [ maintainers.eqyiel ];
  };
}
