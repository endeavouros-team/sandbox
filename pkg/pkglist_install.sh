#!/bin/bash

Message() { echo "===> pkglist_install.sh: $1: $2" ; }

Warning() { Message warning "$1" ; }
Info()    { Message info "$1" ; }

Main() {
    local pkglist="/home/liveuser/user_pkglist.txt"

    if [ ! -f "$pkglist" ] ; then
        Info "no $pkglist found."
        return
    fi

    local chroot_path=$(cat /tmp/chrootpath.txt)

    if [ -n "$(grep "^Install=" $pkglist)" ] || [ -n "$(grep "^Remove=" $pkglist)" ] ; then

        # New: list of installs and removals, using array variables
        #   - Install     Packages to be installed.
        #   - Remove      Packages to be removed.
        # File $pkglist must be using only bash syntax.

        local Install Remove

        source $pkglist || {
            Warning "command 'source $pkglist' failed. Check $pkglist."
            return 1
        }

        if [ -n "$Remove" ] ; then
            local Remove2=() pkg
            for pkg in "${Remove[@]}" ; do
                if (pacman -Q --root $chroot_path "$pkg" >& /dev/null) ; then
                    Remove2+=("$pkg")
                else
                    Warning "package '$pkg' is not avaiable for uninstall. Check $pkglist."
                fi
            done
            pacman -Rsn --noconfirm --root $chroot_path "${Remove2[@]}"
        fi
        if [ -n "$Install" ] ; then
            if (! pacman -Sy --noconfirm --needed --root $chroot_path "${Install[@]}") ; then
                Warning "installing packages from $pkglist failed."
            fi
        fi
    else

        # Old: list of additional installs.

        local pkgs=$(echo $(cat $pkglist | sed 's|#.*||'))  # echo removes white spaces
        if [ -n "$pkgs" ] ; then
            pacman -Sy --noconfirm --needed --root $chroot_path $pkgs
        fi
    fi
}

Main
