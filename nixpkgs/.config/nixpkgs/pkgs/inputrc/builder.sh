source $stdenv/setup
msg_prefix="log:"

mkdir -p $out/etc
cp $src $out/etc/inputrc

create_link "$out/etc/inputrc" "$HOME/.inputrc"