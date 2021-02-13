#!/bin/bash

# Services for the setup.sh:

Warning() {
    echo "$progname: warning: $1" >&2
}


# The following are not meant for setup.sh.

_COMMON_OUT() {
    local type="$1"
    local msg="$2"
    echo "===> $progname: $type: $msg" >&2
}
DIE()  { _COMMON_OUT error   "$1" ; exit 1 ; }
WARN() { _COMMON_OUT warning "$1" ; }
INFO() { _COMMON_OUT info    "$1" ; }

GetChrootPath() {
    local chroot_path

    if [ -f /tmp/chrootpath.txt ] ; then
        # installing, chrooted
        chroot_path="$(cat /tmp/chrootpath.txt | sed 's/\/tmp\///')"
    else
        # installing, not chrooted
        chroot_path="$(lsblk | grep "calamares-root" | awk '{ print $NF }' | sed -e 's/\/tmp\///' -e 's/\/.*$//' | tail -n1)"
    fi

    case "$chroot_path" in
        "") return 1 ;;               # fail
        *)  echo "$chroot_path" ;;    # OK
    esac
}

GetNewUserName() {
    if [ -f /tmp/new_username.txt ] ; then
        cat /tmp/new_username.txt             # installing, chrooted
        return
    fi

    local chroot_path="$(GetChrootPath)"
    local passwd_path=/tmp/$chroot_path/etc/passwd

    if [ -z "$chroot_path" ] || [ ! -d $passwd_path ] ; then
        # not installing, simply running a system normally
        passwd_path=/etc/passwd
    fi

    # not installing, normally in the installed system
    grep "/home/" $passwd_path | cut -d: -f1 | head -n1
}

Main() {
    local progname="$(basename "$0")"   # used in all error messages

    INFO "running $progname to handle setup.sh"

    local REPONAME="$1"
    [ -n "$REPONAME" ] || DIE "must give repository name or URL to it."

    local NEW_USER="$(GetNewUserName)"
    [ -n "$NEW_USER" ] || DIE "Cannot set variable NEW_USER."

    local tmpdir=$(mktemp -d)      # here we work
    pushd $tmpdir >/dev/null

    # check the format of REPONAME:
    case "$REPONAME" in
        *://*) ;;                                                           # any git-based URL
        *) REPONAME="https://github.com/endeavouros-team/$REPONAME.git" ;;  # EndeavourOS repo name from github
    esac

    INFO "user=$NEW_USER, repo=$REPONAME."

    # clone the $REPONAME here
    git clone "$REPONAME" || DIE "cloning '$REPONAME' failed."

    # go to the actual "working" folder
    cd "$REPONAME"

    # check if we have setup.sh
    [ -r setup.sh ] || DIE "repo does not have file setup.sh!"

    # setup.sh should contain this function:
    local required_func=CopyConfigsToUser
    unset -f $required_func

    # read setup.sh contents
    source ./setup.sh || DIE "reading setup.sh failed!"

    # check that setup.sh has the required function:
    declare -F $required_func >/dev/null || DIE "setup.sh does not contain function $required_func"

    # run the function from setup.sh
    $required_func || DIE "running setup.sh failed."

    # cleanup
    popd >/dev/null
    rm -rf $tmpdir

    INFO "$progname succeeded."
}

Main "$@"    # needs REPONAME parameter

# REPONAME examples:
#    endeavouros-i3wm-setup
#    https://github.com/endeavouros-team/endeavouros-i3wm-setup.git
