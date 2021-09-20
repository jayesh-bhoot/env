{ lib, fetchurl, ocamlPackages }:

let
  owner = "LexiFi";
in
  ocamlPackages.buildDunePackage rec {
    pname = "gen_js_api";
    version = "1.0.8";

    useDune2 = true;

    src = fetchurl {
      url = "https://github.com/${owner}/${pname}/archive/refs/tags/v${version}.tar.gz";
      sha256 = "1xd9bgwsrjwn0qzzr82jbnrc691vffmcnwsj7faklg3zb268n841";
    };

    buildInputs = with ocamlPackages; [
      ojs
      ocaml-migrate-parsetree-2
      ppxlib
    ];

    meta = with lib; {
      homepage = "https://github.com/${owner}/${pname}";
      description = "Easy OCaml bindings for Javascript libraries";
      license = licenses.mit;
    # maintainers = [ maintainers.eqyiel ];
  };
}
