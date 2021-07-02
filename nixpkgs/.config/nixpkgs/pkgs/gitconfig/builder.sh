source $stdenv/setup
msg_prefix="log:"

mkdir -p $out/etc
cp $src $out/etc/gitconfig

create_link "$out/etc/gitconfig" "$HOME/.gitconfig"