source $stdenv/setup

dst="$out/share/fonts/truetype"
mkdir -p $dst
cp $src/* $dst/
