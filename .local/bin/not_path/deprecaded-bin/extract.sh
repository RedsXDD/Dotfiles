#!/bin/bash

# Check Root Logging:
if [[ $HOME = /root ]]; then
	echo "Please do not run this script as Root"
	exit
fi

# Get SUDO Perms:
sudo test

# ------------------------------------------------------- #
# Arguments:

t="configs-backup"
tar="$t.tar.gz"
thome="$HOME/$t"
checktar=$(ls $PWD | grep $tar)
mega=$HOME/MEGAsync

# Commands:
move="mv -vf"

# ------------------------------------------------------- #

# mkdir:
mkdir -pv $HOME/MEGAsync

# Extract Tar in /home:
if [[ $checktar = $tar ]]; then
	# Extract File to HOME:
	tar xvf $tar -C $HOME
	# Move Configs & .local:
	sudo $move $thome/.config $HOME/
	sudo $move $thome/.librewolf $HOME/
	sudo $move $thome/.local $HOME/
	# Move Dotfiles:
	sudo $move $thome/.dotfiles /
	# Move Bashrc and Inputrc:
	sudo $move $thome/bash.bashrc /etc/
	sudo $move $thome/inputrc /etc/
	# Move Console and Pacman Configs:
	sudo $move $thome/pacman.conf /etc/
	sudo $move $thome/vconsole.conf /etc/
	# Move Fonts:
	sudo $move $thome/usr/* /usr/share/fonts
	fc-cache -rv
	# Remove Directories:
	sudo rm -rf $thome
else
	echo "Archive file not found in $PWD"
	exit 1
fi

# Copy Tar to MEGAsync:
if [[ $PWD != $mega ]]; then
	mv -vf $tar $mega/
	mv -vf extract.sh $mega/
fi 
