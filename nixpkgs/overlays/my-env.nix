self: super:

let
  mkPath = moduleName: ../pkgs/my-env + "/${moduleName}";
in
  rec {
    bashrc = super.callPackage (mkPath "bashrc") {};
    inputrc = super.callPackage (mkPath "inputrc") {};
    ideavimrc = super.callPackage (mkPath "ideavimrc") {};
    gitconfig = super.callPackage (mkPath "gitconfig") {};
    input-mono-custom = super.callPackage (mkPath "input-mono-custom") {};
    corePackages = super.callPackage (mkPath "core-packages") {};
  }
