source $stdenv/setup

dst="$out/share/fonts/truetype"
mkdir -p $dst
cp $src/InputMono/* $dst/
cp $src/InputMonoCompressed/* $dst/
cp $src/InputMonoCondensed/* $dst/
cp $src/InputMonoNarrow/* $dst/
