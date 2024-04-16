#!/bin/bash

cd $HOME
wget https://mega.nz/linux/repo/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.zst
sudo pacman -Uv --noconfirm --needed $HOME/megasync-x86_64.pkg.tar.zst
rm -rf $HOME/megasync-x86_64.pkg.tar.zst
