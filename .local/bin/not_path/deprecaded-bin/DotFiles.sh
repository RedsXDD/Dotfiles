#!/bin/bash

# Get Sudo Perms:
doas -- test

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

# ------------------------------------------------------- #
# mkdirs:
mkdir -pv $mega
clear

# Removing Old Backup:
doas rm -rvf $configshome/
doas rm -rvf $other/

mkdir -pv $configshome
mkdir -pv $other

# Copying Stuff From /Home:
for file in ~/.{config,local,librewolf,icons};
do
 if [ -e $configshome/$file ]; then
  if [ $file -nt $configshome/$file ]; then
   doas cp -rfv $file $configshome
  fi
 else
  doas cp -rfv $file $configshome
 fi
done
unset file

# Copying Other Dot Files:
doas cp -rv /etc/inputrc $other
doas cp -rv /etc/pacman.conf $other
doas cp -rv /usr/share/libalpm/hooks/redash.hook $other

# Copying Fonts:
doas cp -rv /etc/vconsole.conf $other
doas cp -rv /usr/share/fonts/NerdFonts $allconfigs/usr/

# Removing Unwanted Files:
doas rm -rvf $conf/baloo*
doas rm -rvf $configshome/.local/lib
doas rm -rvf $configshome/.local/state
doas rm -rvf $local/{baloo*,Cryptomator,data,klipper,wallpapers,mc,applications,flatpak,RecentDocuments,Trash,Mousepad}

# Archiving Configs and Moving to MEGA:
cd $HOME
doas tar -cvzpf $tar /.dotfiles
mv -vf $tar $mega

# Backup Complete Prompt:
echo ""
echo "Backup Complete"
echo ""
