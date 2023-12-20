#!/bin/bash

# Collect all changelogs here.

DIE() {
    local progname=${BASH_ARGV0##*/}
    echo "$progname: error: $1" >&2
    exit 1
}

Changelog() {
    local page="${changelogs[$pkg]#*|}"  # URL part

    if [ "$page" ] ; then
        $open "${page}"
    else
        DIE "changelog for '$pkg' not found."
    fi
}
KnownPkgs() {
    echo "${changelogs[@]%%|*}"   # PkgName part
}
KnownURLs() {
    echo "${changelogs[@]#*|}"   # URL part
}

UrlPart() { echo "${changelogs[$1]#*|}" ; }

GetOpener() {
    local open
    for open in kde-open exo-open xdg-open
    do
        which "$open" &>/dev/null && { echo "$open"; return; }
    done
    DIE "cannot find opening app"
}

Main() {
    # Usage: $progname [options] [pkgnames]
    # Options:
    #   --list-known-pkgs
    #   --show-url <pkgname>

    declare -A changelogs=(
        # This array contains all changelogs this app knows of.
        # An assignment has these parts:
        #    [PkgName]="PkgName|URL"
        [bind]="bind|https://gitlab.isc.org/isc-projects/bind9/commits"
    )

    while true ; do
        case "$1" in
            --show-url) UrlPart "$2"; return ;;
        esac
        shift
    done
    
    [ "$1" ] || DIE "please give a package name"

    local open=$(GetOpener)
    local pkg url

    for pkg in $(KnownPkgs) ; do
        url="${changelogs[$pkg]#*|}"
        echo "$pkg = $url"
    done | column -t
}

Main "$@"
