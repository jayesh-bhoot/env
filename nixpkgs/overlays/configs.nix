self: super:

let
  mkPath = moduleName: ../pkgs/configs + "/${moduleName}";
in
  {
    bashrc = super.callPackage (mkPath "bashrc") {};
    inputrc = super.callPackage (mkPath "inputrc") {};
    ideavimrc = super.callPackage (mkPath "ideavimrc") {};
    gitconfig = super.callPackage (mkPath "gitconfig") {};
  }
