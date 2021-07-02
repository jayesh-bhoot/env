# Readme

## How the version control works

This repository employs a directory structure expected by `gnu stow`. On a new system, carry out the following steps:

1. install `nixos`, `nix`, and `home-manager`
1. clone the repo
1. `cd nix-config`
1. `nix-shell -p stow` or `nix run nixpkgs.stow`
1. To set up nixOS-level configuration:
    1. Install in `/etc/nixos`, the configuration files found in repo's `nixos` dir, with `sudo stow -t / nixos`.
    1. Activate the installed configuration in the auto-generated `/etc/nixos/configuration.nix` by importing `configuration_.nix` in `configuration.nix`. 
1. To set up nix user-level configuration, `overlays` configuration, and `home-manager` configuration:
    1. Install in `~/.config/nixpkgs`, the configuration files found in repo's `nixpkgs` dir, with `sudo stow -t ~ nixpkgs`.
    1. Activate the installed configuration in the auto-generated `~/.config/nixpkgs/home.nix` by importing `home_.nix` in `home.nix`. 

I opted to keep `configuration.nix` and `home.nix` out of the version control, using `configuration_.nix` and `home_.nix` instead, in order to **keep `stateVersion` out of version control**.

## Building a custom package

Based on https://nixos.wiki/wiki/Nixpkgs/Modifying_Packages, the best approach to maintaining custom packages is using overlays. Before adding a package to an overlay, it's necessary to test-build it. While test-building a package, the main challenge is to expose the `nixpkgs` ecosystm to the package's `default.nix` file.

One way to do that is to refer the package in the `all-packages.nix`. But it's neither optimal nor clean.

Another way is to import `nixpkgs` within the default.next file:

```
let pkgs = import <nixpkgs> {};
in pkgs.callPackage (
  # whatever is in default.nix
) {}
```

This approach is not clean either. It does not allow reuse of the custom package. In other words, another package will have a difficult time referring to the custom package.

The best way to test build is to temporarily import `nixpkgs`, followed by `callPackage`, in the `nix-build` command,

```
nix-build -E '(import <nixpkgs> {}).callPackage ./default.nix {}'
```

References:

- https://nixos.wiki/wiki/Nixpkgs/Modifying_Packages
- https://github.com/NixOS/nix/issues/2259#issue-336406153
- https://github.com/NixOS/nix/issues/2259#issuecomment-564336799


## Overlays

Nix manual says:

> The list of overlays can be set either explicitly in a Nix expression, or through `<nixpkgs-overlays>` in NIX_PATH, or in user configuration files...

> If one of `~/.config/nixpkgs/overlays.nix` and `~/.config/nixpkgs/overlays/` exists, then we look for overlays at that path...

> Because overlays that are set in NixOS configuration do not affect non-NixOS operations such as nix-env, the overlays.nix option provides a convenient way to use the same overlays for a NixOS system configuration and user configuration: the same file can be used as overlays.nix and imported as the value of nixpkgs.overlays". 

This implies that overlays specified at `~/.config/nixpkgs/overlays` should be processed automatically in nixos or non-nixos environment, without having to feed those to `nixpkgs.overlays` in either `configuration.nix` or `home.nix`. Just ensure that the setup is wholly and correctly `stow`ed. If the content of the repo's `overlays` dir is not visible as a symbolic link inside `~/.config/nixpkgs/overlays`, then the overlays won't be visible to Nix.

**The packages made available through an overlay are not visible to `nix-env`**. The only way I know currently is to declare a package in **`systemPackages` in `configuration.nix` or `home.packages` in `home.nix`**. Issuing a `rebuild` after declaration will build the package or pull it from the local cache, if already built.

## OCaml overlay

OCaml packages are built using `opam2nix`. 

Let's take the example of `uuidm`.

The general process is as follows:

1. Generate a nix packageset that describes the `uuidm` package as well as its dependencies in nix format. `opam2nix resolve` does this by processing the package's `.opam` file, and producing an `opam-selection.nix` file.
1. Build the packages described in `opam-selection.nix`. The entry point is usually defined in a separate `default.nix`. `nix-build` uses this `default.nix` to trigger the build process.

`opam2nix` can build a package out of local as well as remote source.

### Build from remote source

The OCaml package you want to build must be present in the official `ocaml/opam-repository`.

1. `mkdir pkgs/uuidm && cd pkgs/uuidm`

1. `opam2nix resolve uuidm` to automatically fetch `uuidm.opam` file from the `opam-repository`, and generate `opam-selection.nix`. Not using a local `.opam` file configures the `uuidm` package in `opam-selection.nix` such that source-code will be looked for in the `opam-repository`. Hence, the source code need not be locally available.

     ```
   ...
    uuidm = 
    {
      ...
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
    ...
   ```

1. Write a `default.nix` file. We need not specify `src` attr here.

   ```
   { ocaml, opam2nix }:

   let
     selection = opam2nix.build {
       inherit ocaml;
       selection = ./opam-selection.nix;
     };
   in
   selection.uuidm
   ```

1. Trigger the build process with `nix-build --no-out-link --keep-failed -E '(import <nixpkgs> {}).callPackage ./default.nix {}'`.

### Build from local source

`opam2nix's` readme suggests this approach.

1. `mkdir pkgs/uuidm && cd pkgs/uuidm`

1. Download and extract the source code of `uuidm` from `opam-repository`. It will also contain the `uuidm.opam` file.

1. `opam2nix resolve ./uuidm.opam` to generate `opam-selection.nix`. Using a local `.opam` file configures the `uuidm` package in `opam-selection.nix` such that source-code will *not* be looked for in the `opam-repository`. Hence, the source code must be locally available.

1. Write a `default.nix` file. We need to specify the `src` attr here, while making sure that the source code is locally available.

      ```
   { ocaml, opam2nix }:

   let
     selection = opam2nix.build {
       inherit ocaml;
       selection = ./opam-selection.nix;
       src = ./.;
     };
   in
   selection.uuidm
   ```

   Make sure that the source code is locally available. Keeping only `.opam` file locally available is not enough. `opam2nix` does not complain if source code is locally absent, but it also does not fetch it, and hence the build process fails later.

1. Trigger the build process with `nix-build --no-out-link --keep-failed -E '(import <nixpkgs> {}).callPackage ./default.nix {}'`.

**I found the remote approach much better as it's way less cumbersome**. There is no need to maintain the source code locally.

### dream

problem faced in building `digestif` dependency. solution: `patchShebang`, which led to another problem in macOS.

`utop -require digestif.c` to correctly use `dream` in utop.

## TODO

+ share code like `create_link` across builder scripts
- fold `nixos/modules/*` within `configuration_.nix`
- replace `source ~/.config/nvim/init.vim` with `source ${pkgs.neovimrc}` in ideavimrc?
- Populate the XDG_* env variables (in .profile or .bashrc?).
- Fix the ready-made packaged fonts installation for macOS. For example, Installing to Fira will not copy to ~/Library/Fonts.
- Verify whether ready-made packaged fonts work on Linux with a simple `nix-env -i`. (`fc-cache` needed?)
- Should I abandon linking to non-nix directories? For example, I could just add ~/.nix-profile/share/fonts As one of the directories to check for fonts? Wouldn't this work if I add ~/.nix-profile/share to XDG_DATA_DIRS?
- Should I link ~/.nix-profile/etc/bashrc to ~/.bashrc? or the /nix/store/<hash>-bashrc-<ver>/etc/bashrc to ~/.bashrc?
- split corePackages into several packages