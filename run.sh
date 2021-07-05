function create_link {
    target=$1; link=$2
    if [ -L $link ]; then
        curr_link_target=$(readlink $link)
        if [ $curr_link_target = $target ]; then
            echo "Info: $link already points to $target."
        else
            echo "Error: $link already exists and points to $curr_link_target. Please handle it and run the script again."
            exit 1
        fi
    elif [ -e $link ]; then
        echo "Error: $link already exists. Please handle it and run the script again."
        exit 1
    else
        echo "Info: Pointing $link to $target"
        ln -s $target $link
    fi
}

# todo: stow -R
case $(uname) in
    *NixOS*)
        nix-env -iA nixos.corePackages
        ;;

    *)
        nix-env -iA nixpkgs.corePackages
        ;;
esac

nix_profile="$HOME/.nix-profile"
create_link $nix_profile/etc/bashrc $HOME/.bashrc
create_link $nix_profile/etc/bash_profile $HOME/.bash_profile
create_link $nix_profile/etc/inputrc $HOME/.inputrc
create_link $nix_profile/etc/ideavimrc $HOME/.ideavimrc
create_link $nix_profile/etc/gitconfig $HOME/.gitconfig

case $(uname -s) in
    Linux)
        echo "L"
        src="$nix_profile/share/fonts/InputMonoCustom"
        dst="$HOME/.local/share/fonts/InputMonoCustom"
        mkdir -p $HOME/.local/share/fonts
        create_link $src $dst
        echo "Info: Refreshing font cache"
        fc-cache $dst
        src=;dst=
        ;;

    Darwin)
        echo "D"
        src="$(readlink -f $nix_profile/share/fonts/InputMonoCustom)"
        dst="$HOME/Library/Fonts/InputMonoCustom"
        $DRY_RUN_CMD rm -rf $VERBOSE_ARG $dst
        $DRY_RUN_CMD cp -r $VERBOSE_ARG $src $dst
        $DRY_RUN_CMD find $VERBOSE_ARG $dst -type d -exec chmod 744 {} \;
        $DRY_RUN_CMD find $VERBOSE_ARG $dst -type f -exec chmod 644 {} \;
        src=;dst=
        ;;

    *)
        echo "Error: Unknown system $(uname -s). Cannot install fonts."
esac
