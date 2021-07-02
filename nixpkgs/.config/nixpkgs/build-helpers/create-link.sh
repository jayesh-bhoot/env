function create_link {
    target=$1; link=$2
    echo "$msg_prefix Linking $target to $link"

    if [ -e $link ]; then
        if [ -L $link ]; then
            echo "$link exists as a symbolic link. Renaming it to $link.old.symlink"
            mv $link $link.old.symlink
        else
            echo "Error: A regular file exists at $link. Please back it up and try to reinstall. Exiting without installing"
            exit 1
        fi
    fi
    
    ln -s $target $link
}