#!/bin/bash

# Arguments:

# Reference:
# pacmanC		$(pacman -Qq | grep $n)
# snapC			$(snap list --all | grep $n)
# flatC			$(flatpak list | grep $n)
# cowsay nooenhoe nsnake fpewjepje io.github.peazip.PeaZip snap-store mopejonfo

#Install:
pacmanS="sudo pacman -Sv --color always --noconfirm --needed"
yayS="yay -Sv --color always --noconfirm --needed --cleanafter --removemake"
snapS="sudo snap install --color=always --unicode=always"
flatS="flatpak install --app -yv"

# Remove:
pacmanr="sudo pacman -Rusv --color always --confirm"
snapr="sudo snap remove --purge"
flatr="flatpak remove --delete-data -yv"

# -------------------------------------------------------------------------------------------------------------------------------- #

# Check for Valid Sintaxes and Create a Package List:
[[ -z $1 ]] &&
echo "Please Use one of The Following Functions" &&
echo "S -> Install Packages" &&
echo "R -> Remove Packages" &&
exit ||
[[ $1 = S ]] &&
 # Selecting Packages:
 echo "Please Select The Packages You Want To Install:" &&
 read -r packagelist &&
 # Install Packges with Loop:
 for n in $packagelist;
 do
  # Pacman Install:
  if [[ -n $(pacman -Ss $n) && -z $(pacman -Qs $n) ]]; then
   $pacmanS $n
   continue
  # AUR Install:
  elif [[ -n $(yay -Ss $n) && -z $(pacman -Qs $n) ]]; then
   $yayS $n
   continue
#  # Snap Install:
#  elif [[ -n $(snap find $n) && -z $(snap list --all $n) ]]; then
#   $snapS $n
#   continue
  # Flatpak Install:
  elif [[ -n $(flatpak search $n) && -z $(flatpak list $n) ]]; then
   $flatS $n
   continue
  fi
 done &&
exit

[[ $1 = R ]] &&
 # Selecting Packages:
 echo "Please Select The Packages You Want To Remove:";
 read packagelist &&
 # Install Packges with Loop:
 for n in $packagelist;
 do
  # Pacman Remove:
  if [[ -n $(pacman -Qs $n) ]]; then
   $pacmanr $n
   continue
  # Snap Remove:
  elif [[ -n $(snap list --all $n) ]]; then
   $snapr $n
   continue
  # Flatpak Remove:
  elif [[ -n $(flatpak list $n) ]]; then
   $flatr $n
   continue
  fi
 done &&
exit
