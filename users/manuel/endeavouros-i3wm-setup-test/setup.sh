#!/bin/bash

CopyConfigsToUser() {
    # This function copies the cloned configurations to user's home folder (/home/$NEW_USER).
    #
    # Assume:
    #   - You are in a temporary folder where all configurations are already cloned.
    #     The folder will be automatically deleted afterwards.
    #   - Variable NEW_USER already contains the user name.

    cp -R .config /home/$NEW_USER/
    chmod -R +x /home/$NEW_USER/.config/i3/scripts
    cp .gtkrc-2.0 /home/$NEW_USER/
    chown -R $NEW_USER:$NEW_USER /home/$NEW_USER/.config
    chown $NEW_USER:$NEW_USER /home/$NEW_USER/.gtkrc-2.0
}
