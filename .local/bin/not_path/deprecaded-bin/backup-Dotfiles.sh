#!/bin/bash

# Check Root Logging:
if [[ $HOME = /root ]]; then
	echo "Please do not run this script as Root"
	exit
fi

# Get Sudo Perms:
sudo test

# ------------------------------------------------------- #
# Arguments:

# Mega:
mega="$HOME/MEGAsync/dots"

# /Home Configs:
allconfigs="/.dotfiles/.All-Configs"
other="$allconfigs/Other-Dots"
configshome="$allconfigs/Home"

# Destinations:
conf="$configshome/.config"
local="$configshome/.local/share"
tar="dots.tar.gz"

### DEs & WMs Configs: ### 
dw="/.dotfiles/.All-Configs/DEs-and-WMs"
## .Config: ##
GNOMEc="$dw/GNOME/.config"
KDEc="$dw/KDE/.config"
xfcec="$dw/xfce/.config"
i3c="$dw/i3/.config"
Awesomec="$dw/Awesome/.config"
## .Local/Share: ##
KDEl="$dw/KDE/.local"
xfcel="$dw/xfce/.local"

# Commands:
copy="cp -arv"
move="mv -vf"
del="rm -rvf"

# ------------------------------------------------------- #

echo "Starting Backup ....."

# Remove Old Files:
$del $allconfigs/usr/*
$del $other/*
$del $configshome/.*
$del $xfcec/*
$del $xfcel/*
$del $GNOMEc/*
$del $KDEc/*
$del $KDEl/*
$del $i3c/*
$del $Awesomec/*

mkdir -pv $mega

# Copying Stuff From /Home:
$copy $HOME/.config $configshome
$copy $HOME/.local $configshome
$copy $HOME/.librewolf $configshome
$copy $HOME/.icons $configshome

# Copying Other Dot Files:
sudo $copy /etc/bash $other
sudo $copy /etc/inputrc $other
sudo $copy /etc/pacman.conf $other
sudo $copy /etc/pacman.d/mirrorlist $other

# Copying Fonts:
sudo $copy /etc/vconsole.conf $other
sudo $copy /usr/share/fonts/* $allconfigs/usr/

# Removing Unwanted Files:
$del $conf/baloo*
$del $local/share/baloo*
$del $local/share/Cryptomator
$del $local/share/data
$del $local/share/klipper
$del $local/share/RecentDocuments
$del $local/share/Trash

### Moving DEs & WMs Configs: ###

## KDE: ##
# .Config:
$move $conf/Plasma* $KDEc
$move $conf/k* $KDEc
$move $conf/plasma* $KDEc
$move $conf/akregatorrc $KDEc
$move $conf/discoverrc $KDEc
$move $conf/sddmthemeinstallerrc $KDEc
# .Local/Share:
$move $local/k* $KDEl
$move $local/plasma* $KDEl
$move $local/sddm $KDEl
$move $local/dolphin $KDEl

## Xfce: ##
# .Config:
$move $conf/xfce4 $xfcec
# .Local/Share:
$move $local/xfce4 $xfcel

## i3: ##
$move $conf/i3 $i3c

# Extras Before Archiving:
$move $KDEc/keepassxc $conf

# Archiving Configs and Moving to MEGA:
cd $HOME
sudo tar cvSzpf $tar /.dotfiles
$move $tar $mega

# Backup Complete Prompt:
echo ""
echo "Backup Complete"
echo ""
