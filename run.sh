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

function copy_fonts {
    src=$1; dst=$2
    mkdir -p $dst
    for f in $src/*
    do
        cp $(readlink -f $f) $dst/
    done
    find $dst -type d -exec chmod 744 {} \;
    find $dst -type f -exec chmod 644 {} \;
    src=;dst=
}

# todo: stow -R?

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
        create_link "$nix_profile/share/fonts" "$HOME/.local/share/fonts"
        echo "Info: Refreshing font cache"
        fc-cache "$HOME/.local/share/fonts"
        ;;

    Darwin)
        echo "Info: Copying fonts"
        copy_fonts "$nix_profile/share/fonts/truetype" "$HOME/Library/Fonts/truetype"
        copy_fonts "$nix_profile/share/fonts/opentype" "$HOME/Library/Fonts/opentype"
        ;;

    *)
        echo "Error: Unknown system $(uname -s). Cannot install fonts."
esac
