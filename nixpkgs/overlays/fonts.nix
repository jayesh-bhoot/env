self: super:

{
  fira-code-static = super.callPackage ../pkgs/fira-code-static.nix {};
  iosevka-custom = super.callPackage ../pkgs/iosevka-custom {};
  input-mono-custom = super.callPackage ../pkgs/input-mono-custom {};
}
