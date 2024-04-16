#!/bin/bash

# Check Root Logging:
if [[ $HOME = /root ]]; then
	echo "Please do not run this script as Root"
	exit
fi

### Program Arguments:
PI="sudo pacman -Syuv --needed --noconfirm "
#YI="yay -Syuv --needed --noconfirm --cleanafter --removemake"
#PR="sudo pacman -Rusnv --noconfirm"
#SI="sudo snap install"
#FI="flatpak install -yv flathub"

### Other Arguments:
sources="$HOME/.sources"

# Remove Non-Needed Stuff:
$PR nano
$PR konsole
$PR kate
$PR mousepad
$PR xfce4-terminal

# Installing Basic Stuff after Minimal Arch Install:
#$PI xf86-video-fbdev
#$PI xorg
#$PI xorg-xinit
#$PI nitrogen
#$PI picom
#$PI nvim
#$PI base-devel
$PI git
$PI wget
#$PI dmenu

### Mkdirs:
mkdir -pv $HOME/.sources

# Enabling Arch User Repository:
cd $sources
git clone https://aur.archlinux.org/yay.git $sources/yay/
cd $sources/yay/
makepkg -si --noconfirm --needed
cd $HOME

# Enabling Snap Packs:
cd $sources
git clone https://aur.archlinux.org/snapd.git $sources/snapd/
cd $sources/snapd/
makepkg -si --noconfirm --needed
sudo systemctl enable --now snapd.socket
sudo systemctl enable --now snapd.apparmor
sudo ln -s /var/lib/snapd/snap /snap
cd $HOME

# Enabling Flatpaks:
$PI flatpak

# Install MEGA Desktop App:
#wget https://mega.nz/linux/repo/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.zst
#sudo pacman -Uv --noconfirm --needed $HOME/megasync-x86_64.pkg.tar.zst
#rm -rf $HOME/megasync-x86_64.pkg.tar.zst

### Repository Packages:
# Volume Control:
$PI pavucontrol
# For GTK Customization:
$PI lxappearance
# For Qt Customization:
$PI qt5ct
# Terminal Music Player:
$PI cmus
# Command Manual:
$PI man-db
# Simpler Man:
$PI tldr
# Terminal Emulator:
$PI alacritty
# Password Manager:
$PI keepassxc
# Text Editors:
#$PI neovim
#$PI micro
# File Managers:
$PI mc
$PI pcmanfm-gtk3
# See Thumbnails in File Managers:
$PI totem
# Video Player:
$PI mpv
# Clipboard:
$PI xclip
# Partition Manager:
$PI gparted
# Better ls Command:
$PI exa
# Disk Space Checker:
$PI gdu
# Better cat Command:
$PI bat
# System Monitor
$PI bpytop
# NTFS Support for Linux:
#$PI ntfs-3g
# Youtube Downloader:
$PI youtube-dl
$PI atomicparsley
# Terminal Image Viewer:
#PI chafa
# Video Library:
$PI ffmpeg
# Mouse Support for TTYs:
#PI gpm
# Colorized Man Page:
$PI most
# Keyboard Shortcuts:
$PI sxhkd

### AUR Packages:
# LibreWolf Browser:
$YI librewolf-bin
# Brave Browser:
$YI brave-bin
# Themes For Alacritty:
$YI alacritty-themes
# Backup Tool:
#$YI timeshift-bin
# File Syncer:
#$YI rsync
# Rsync for Cloud Storage:
#$YI rclone
# Internet Speed Tester:
#$YI speedometer

## Install Flatpacks Programs:
# Cryptomator:
$FI org.cryptomator.Cryptomator
# Tor Browser:
$FI com.github.micahflee.torbrowser-launcher
# Animated Wallpapers:
$FI io.github.jeffshee.Hidamari

### Fun Commands:
# Fetch System:
$PI neofetch
# Rainbow Texts:
$PI lolcat
# Cows can Talk:
$PI cowsay
# Text to Ascii Text:
$PI figlet
# Get a nice(or not) Fortune Text:
$YI fortune-mod-off

# Fonts:
$PI powerline-fonts
$PI awesome-terminal-fonts
$PI ttf-font-awesome
$PI ttf-hanazono
$PI otf-ipafont
$PI adobe-source-han-serif-jp-fonts
$PI adobe-source-han-sans-jp-fonts

### Archive Extraction:
$PI zip
$PI unzip
$PI unrar
$PI pzip
$PI tar

# Themes:
$PI arc-gtk-theme
$YI lightly-git
#oxygen
#qtcurve-qt5
#adwaita-qt5
#qt5-styleplugins
#kvantum
#adapta-gtk-theme
#arc-solid-gtk-theme
#xcfe-theme-bluebird
#breeze-gtk
#deepin-gtk-theme
#gnome-themes-extra
#xfce-theme-graybird
#materia-gtk-theme
#mate-themes
#numix-gtk-theme-git
#vertex-themes
#zuki-themes

### Extra Stuff:
#sudo systemctl start --now gpm
