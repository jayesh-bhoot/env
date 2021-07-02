source $stdenv/setup
msg_prefix="log:"

dst="$out/share/fonts/InputMonoCustom"
mkdir -p $dst
cp -r $src/* $dst/

if [ $is_darwin -gt 0 ]; then
    link="$HOME/Library/Fonts/InputMonoCustom"
    $DRY_RUN_CMD rm -rf $VERBOSE_ARG $link
    $DRY_RUN_CMD cp -r $VERBOSE_ARG $dst $link
    $DRY_RUN_CMD find $VERBOSE_ARG $link -type d -exec chmod 744 {} \;
    $DRY_RUN_CMD find $VERBOSE_ARG $link -type f -exec chmod 644 {} \;
else
    link="$HOME/.local/share/fonts/InputMonoCustom"
    create_link $dst $link
fi