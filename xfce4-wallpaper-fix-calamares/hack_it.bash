#!/bin/bash

cp shellprocess_general_fixes.conf /etc/calamares/modules/
cp pacstrap.conf /etc/calamares/modules/
cp general-fixes.bash /etc/calamares/scripts/
cp generate-xfce4-desktop-xml /etc/calamares/scripts/
chmod +x /etc/calamares/scripts/*
cp settings_online.conf /etc/calamares/
