source $stdenv/setup

dst="$out/share/fonts/InputMonoCustom"
mkdir -p $dst
cp -r $src/* $dst/
