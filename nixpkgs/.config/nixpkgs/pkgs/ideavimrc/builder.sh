source $stdenv/setup
msg_prefix="log:"

mkdir -p $out/etc
cp $src $out/etc/ideavimrc

create_link "$out/etc/ideavimrc" "$HOME/.ideavimrc"