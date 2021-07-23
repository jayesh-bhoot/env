{ lib, fetchurl, ocamlPackages }:

let
  owner = "LexiFi";
  repoName = "gen_js_api";
in
  ocamlPackages.buildDunePackage rec {
    pname = "ojs";
    version = "1.0.8";

    useDune2 = true;


    src = fetchurl {
      url = "https://github.com/${owner}/${repoName}/archive/refs/tags/v${version}.tar.gz";
      sha256 = "1xd9bgwsrjwn0qzzr82jbnrc691vffmcnwsj7faklg3zb268n841";
    };

    meta = with lib; {
      homepage = "https://github.com/${owner}/${repoName}";
      description = "Runtime Library for gen_js_api generated libraries. To be used in conjunction with gen_js_api";
      license = licenses.mit;
    # maintainers = [ maintainers.eqyiel ];
  };
}
