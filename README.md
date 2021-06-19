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

Nix manual says: "The list of overlays can be set either explicitly in a Nix expression, or through `<nixpkgs-overlays>` in NIX_PATH, or in user configuration files... If one of `~/.config/nixpkgs/overlays.nix` and `~/.config/nixpkgs/overlays/` exists, then we look for overlays at that path... Because overlays that are set in NixOS configuration do not affect non-NixOS operations such as nix-env, the overlays.nix option provides a convenient way to use the same overlays for a NixOS system configuration and user configuration: the same file can be used as overlays.nix and imported as the value of nixpkgs.overlays". 

This implies that overlays specified at `~/.config/nixpkgs/overlays` should be processed automatically in nixos or non-nixos environment, without having to feed those to `nixpkgs.overlays` in either `configuration.nix` or `home.nix`. Just ensure that the setup is wholly and correctly stowed. If `overlays` in the repo is not visible as a symbolic link at `~/.config/nixpkgs/overlays`, then the overlays won't be visible to Nix.


**The packages made available through an overlay are not visible to `nix-env`**. The only way I know currently is to declare a package in **`systemPackages` in `configuration.nix` or `home.packages` in `home.nix`**. Issuing a `rebuild` after declaration will build the package or pull it from the local cache, if already built.

## OCaml overlay

powered by `opam2nix`.

### opam2nix

`opam2nix resolve <package-name-on-opam>` best approach. No need to download `.opam` and source, and no need to specify `src` attr in `package/default.nix`.

### dream

problem faced in building `digestif` dependency. solution: `patchShebang`, which led to another problem in macOS.

`utop -require digestif.c` to correctly use `dream` in utop.
