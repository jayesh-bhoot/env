source $stdenv/setup

mkdir -p $out/etc
cp $src $out/etc/bashrc
# macOS at least does not read .bashrc automatically. So source it in .bash_profile.
echo "[ -s ~/.bashrc ] && source ~/.bashrc" >> $out/etc/bash_profile
