#!/bin/bash

# Echo: outputs a line.
Echo() {
    echo "====> $*"
}

# Run: shows and runs a command.
Run()  {
    Echo "$@"
    "$@"
}

Main() {
    Echo "Running setup.sh."

    if [ -f /tmp/new_username.txt ]
    then
        NEW_USER=$(cat /tmp/new_username.txt)
    else
        NEW_USER=$(cat /tmp/$chroot_path/etc/passwd | grep "/home" |cut -d: -f1 |head -1)
    fi
    Echo "NEW_USER: $NEW_USER"

    Run git clone https://github.com/endeavouros-team/endeavouros-i3wm-setup.git
    Run cd endeavouros-i3wm-setup
    Run cp -R .config /home/$NEW_USER/                                               
    Run chmod -R +x /home/$NEW_USER/.config/i3/scripts
    Run cp .gtkrc-2.0 /home/$NEW_USER/
    Run chown -R $NEW_USER:$NEW_USER /home/$NEW_USER/.config
    Run chown $NEW_USER:$NEW_USER /home/$NEW_USER/.gtkrc-2.0
    Run cd ..
    Run rm -rf endeavouros-i3wm-setup

    Echo "Running setup.sh ended."
}

Main "$@"
