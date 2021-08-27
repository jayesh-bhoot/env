{ pkgs }:

# https://github.com/luke-clifton/nix-config/blob/master/config.nix
# https://www.thedroneely.com/posts/declarative-user-package-management-in-nixos/
pkgs.buildEnv {
    name = "my-env";
    paths = import ./packages.nix pkgs;
}
