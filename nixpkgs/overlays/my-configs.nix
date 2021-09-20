self: super:

{
  bashrc = super.callPackage ../pkgs/bashrc {};
  inputrc = super.callPackage ../pkgs/inputrc {};
  ideavimrc = super.callPackage ../pkgs/ideavimrc {};
  gitconfig = super.callPackage ../pkgs/gitconfig {};
}
