self: super:

{
  fira-code-static = super.callPackage ../pkgs/fonts/fira-code-static {};
  iosevka-custom = super.callPackage ../pkgs/fonts/iosevka-custom {};
  input-mono-custom = super.callPackage ../pkgs/fonts/input-mono-custom {};
}
