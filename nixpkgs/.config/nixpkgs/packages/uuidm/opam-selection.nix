### This file is generated by opam2nix.

self:
let
    lib = self.lib;
    pkgs = self.pkgs;
    repoPath = self.repoPath;
    repos = 
    {
      opam-repository = 
      rec {
        fetch = 
        {
          owner = "ocaml";
          repo = "opam-repository";
          rev = "6442db2bfb03f92548c120b0c33a38b4e471b84e";
          sha256 = "1mr8bxy8ymdjriq0685q869jhvbbb5a2v4qzn5ypm635glmbn1mq";
        };
        src = (pkgs.fetchFromGitHub) fetch;
      };
    };
    selection = self.selection;
in
{
  format-version = 4;
  ocaml-version = "4.12.0";
  repos = repos;
  selection = 
  {
    ocaml = 
    {
      opamInputs = 
      {
        ocaml-base-compiler = selection.ocaml-base-compiler or null;
        ocaml-config = selection.ocaml-config;
        ocaml-system = selection.ocaml-system or null;
        ocaml-variants = selection.ocaml-variants or null;
      };
      opamSrc = repoPath (repos.opam-repository.src) 
      {
        hash = "sha256:0xrq7j9zfynk524j69i3and0mqgi32wav751s4cqc1q7pqm47xpc";
        package = "packages/ocaml/ocaml.4.12.0";
      };
      pname = "ocaml";
      src = null;
      version = "4.12.0";
    };
    ocaml-base-compiler = 
    {
      opamInputs = {
      };
      opamSrc = repoPath (repos.opam-repository.src) 
      {
        hash = "sha256:0gf3z9qmi976x4iwndfslcim50ickla52x9fp94aqxrgvsy1ypn7";
        package = "packages/ocaml-base-compiler/ocaml-base-compiler.4.12.0";
      };
      pname = "ocaml-base-compiler";
      src = pkgs.fetchurl 
      {
        sha256 = "0i37laikik5vwydw1cwygxd8xq2d6n35l20irgrh691njlwpmh5d";
        url = "https://github.com/ocaml/ocaml/archive/4.12.0.tar.gz";
      };
      version = "4.12.0";
    };
    ocaml-config = 
    {
      opamInputs = 
      {
        ocaml-base-compiler = selection.ocaml-base-compiler or null;
        ocaml-system = selection.ocaml-system or null;
        ocaml-variants = selection.ocaml-variants or null;
      };
      opamSrc = repoPath (repos.opam-repository.src) 
      {
        hash = "sha256:0h0hgqq9mbywvqygppfdc50gf9ss8a97l4dgsv3hszmzh6gglgrg";
        package = "packages/ocaml-config/ocaml-config.2";
      };
      pname = "ocaml-config";
      src = null;
      version = "2";
    };
    ocamlbuild = 
    {
      opamInputs = {
                     ocaml = selection.ocaml;
      };
      opamSrc = repoPath (repos.opam-repository.src) 
      {
        hash = "sha256:0hrzb4fgz7qh7cr65j5yq6fai82fhyl6bp8s9pwcj1a2yhczbviv";
        package = "packages/ocamlbuild/ocamlbuild.0.14.0";
      };
      pname = "ocamlbuild";
      src = pkgs.fetchurl 
      {
        sha256 = "0y1fskw9rg2y1zgb7whv3v8v4xw04svgxslf3856q2aqd7lrrcl7";
        url = "https://github.com/ocaml/ocamlbuild/archive/0.14.0.tar.gz";
      };
      version = "0.14.0";
    };
    ocamlfind = 
    {
      opamInputs = 
      {
        graphics = selection.graphics or null;
        ocaml = selection.ocaml;
      };
      opamSrc = repoPath (repos.opam-repository.src) 
      {
        hash = "sha256:11avrzm0gdc6mz7dazr8q18ir5429ckc36s2mv0l8722znq8lc3k";
        package = "packages/ocamlfind/ocamlfind.1.9.1";
      };
      pname = "ocamlfind";
      src = pkgs.fetchurl 
      {
        sha256 = "1qhgk25avmz4l4g47g8jvk0k1g9p9d5hbdrwpz2693a8ajyvhhib";
        url = "http://download.camlcity.org/download/findlib-1.9.1.tar.gz";
      };
      version = "1.9.1";
    };
    topkg = 
    {
      opamInputs = 
      {
        ocaml = selection.ocaml;
        ocamlbuild = selection.ocamlbuild;
        ocamlfind = selection.ocamlfind;
      };
      opamSrc = repoPath (repos.opam-repository.src) 
      {
        hash = "sha256:1asjip3cr84b1n1n4q8b5zrcki87niz6imb9m9zaj2kqdywmp0m5";
        package = "packages/topkg/topkg.1.0.3";
      };
      pname = "topkg";
      src = pkgs.fetchurl 
      {
        sha256 = "0b77gsz9bqby8v77kfi4lans47x9p2lmzanzwins5r29maphb8y6";
        url = "http://erratique.ch/software/topkg/releases/topkg-1.0.3.tbz";
      };
      version = "1.0.3";
    };
    uuidm = 
    {
      opamInputs = 
      {
        cmdliner = selection.cmdliner or null;
        ocaml = selection.ocaml;
        ocamlbuild = selection.ocamlbuild;
        ocamlfind = selection.ocamlfind;
        topkg = selection.topkg;
      };
      opamSrc = repoPath (repos.opam-repository.src) 
      {
        hash = "sha256:0gczj4p886wzyjr11x4wg5qwvj6lvzb1rnhy0l9ya7z01n51bkwr";
        package = "packages/uuidm/uuidm.0.9.7";
      };
      pname = "uuidm";
      src = pkgs.fetchurl 
      {
        sha256 = "1ivxb3hxn9bk62rmixx6px4fvn52s4yr1bpla7rgkcn8981v45r8";
        url = "https://erratique.ch/software/uuidm/releases/uuidm-0.9.7.tbz";
      };
      version = "0.9.7";
    };
  };
}

