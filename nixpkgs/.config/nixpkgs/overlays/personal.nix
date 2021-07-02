self: super:

rec {
  bashrc = super.callPackage ../pkgs/bashrc {};
  inputrc = super.callPackage ../pkgs/inputrc {};
  ideavimrc = super.callPackage ../pkgs/ideavimrc {};
  gitconfig = super.callPackage ../pkgs/gitconfig {};
  input-mono-custom = super.callPackage ../pkgs/input-mono-custom {};
  corePackages = super.callPackage ../pkgs/core-packages {};
}
