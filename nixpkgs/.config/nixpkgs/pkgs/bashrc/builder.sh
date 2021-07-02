source $stdenv/setup
msg_prefix="log:"

mkdir -p $out/etc
cp $src $out/etc/bashrc
# macOS at least does not read .bashrc automatically. So source it in .bash_profile.
echo "[ -s ~/.bashrc ] && source ~/.bashrc" >> $out/etc/bash_profile

create_link "$out/etc/bashrc" "$HOME/.bashrc"
create_link "$out/etc/bash_profile" "$HOME/.bash_profile"