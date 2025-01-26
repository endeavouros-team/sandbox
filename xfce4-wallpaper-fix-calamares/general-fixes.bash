#!/bin/bash

if [[ -f /home/${USER}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml ]]; then
    /etc/calamares/scripts/generate-xfce4-desktop-xml --detected /home/${USER}/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
fi
