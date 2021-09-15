{ vim-iced, stdenv }:

# adapted from: https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/vimacs.nix
# Like vim-iced, vimacs plugin also provides a binary (bin/vim) which needs to be exposed to $PATH explicitly.

# In Nix, ~/.nix-profile/bin (which itself is a symlink that points to the current Nix profile) is exposed to $PATH, and all the binaries in the `bin` dir of the installed derivations of the current profile are symlinked inside ~/.nix-profile/bin.
# The problem is a derivation's `bin` is symlinked to ~/.nix-profile only if the derivation is installed directly (and not indirectly like vim-iced, which is handled by neovim).

# The solution for vimacs is to have two derivations:
# vimPlugins.vimacs, which acts as the actual vim plugin, and
# vimacs, which links to the content of `vimPlugins.vimacs` so as not to duplicate them, and then exposes `vimacs` binary within to $PATH.

# This derivation follows the same approach: expose the `iced` binary from the `vim-iced` plugin derivation by symlinking to the full contentof `vim-iced`. Symlinking to just `bin/iced` raises errors while invoking `iced repl`. So better safe than sorry.

stdenv.mkDerivation rec {
  pname = "iced-repl";
  version = vim-iced.version;
  buildInputs = [ vim-iced ];
  buildCommand = ''
    ln -s "${vim-iced}"/share/vim-plugins/vim-iced $out
  '';
}
