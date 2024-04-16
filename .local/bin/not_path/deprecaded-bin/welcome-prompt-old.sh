#!/usr/bin/env sh

# __        __   _
# \ \      / /__| | ___ ___  _ __ ___   ___
#  \ \ /\ / / _ \ |/ __/ _ \| '_ ` _ \ / _ \
#   \ V  V /  __/ | (_| (_) | | | | | |  __/
#    \_/\_/ \___|_|\___\___/|_| |_| |_|\___|
#  ____                            _
# |  _ \ _ __ ___  _ __ ___  _ __ | |_ ___
# | |_) | '__/ _ \| '_ ` _ \| '_ \| __/ __|
# |  __/| | | (_) | | | | | | |_) | |_\__ \
# |_|   |_|  \___/|_| |_| |_| .__/ \__|___/
#                           |_|

# =================================================================================================================================================================== #

# Functions & Arguments
random="$(od -vAn -N4 -tu < /dev/urandom | sed 's/\s//g')"
## Core Functions:
# Normal Distro List:
distrolist(){ neofetch --help | \grep -A 10000 '\--ascii_distro' | sed '/small/q' | \grep -A 10000 'NOTE:' | sed 's/^\s*//g; s/^$//g' | sed 's/.*/&/' | paste -sd' ' -; }
# All Main Distros:
listnormal(){ distrolist | sed "s/\s*have.*//; s/NOTE:\s//; s/Linspire, Linux/Linspire Linux/; s/,\s*/\n/g"; }
# Distros with Old Variants:
listold(){ distrolist | sed "s/.*ascii//; s/have.*//; s/.*NOTE.\s//; s/,\s*/_old\n/g"; }
# Distros with Small Variants:
listsmall(){ distrolist | sed "s/.*old//g; s/.*NOTE.\s//; s/\shave.*/_small/; s/,\s*/_small\n/g"; }
# Distro List with All Variants Combined:
listall(){ listnormal && listold && listsmall; }

# Determinate List Lenghts:
Snormal="$(listnormal | wc -l)"
Sold="$(listold | wc -l)"
Ssmall="$(listsmall | wc -l)"
Sall="$(listall | wc -l)"

# Randomly Choose a Line From list:
Nnormal="$(( $random % ( $Snormal - 1 ) + 1 ))"
Nold="$(( $random % ( $Sold - 1 ) + 1 ))"
Nsmall="$(( $random % ( $Ssmall - 1 ) + 1 ))"
Nall="$(( $random % ( $Sall - 1 ) + 1 ))"

# Select Distro Based on Choosen Line:
Dnormal=$(listnormal | sed "$Nnormal!d")
Dold=$(listold | sed "$Nold!d")
Dsmall=$(listsmall | sed "$Nsmall!d")
Dall=$(listall | sed "$Nall!d")

# Display Choosen Distro Logo:
case $(($random%3)) in
 0)
  echo ""
  echo "$(tput bold)Displayed Distro: $Dnormal"
  echo ""
  neofetch --ascii_distro "$Dnormal"
 ;;
 1)
  echo ""
  echo "$(tput bold)Displayed Distro: $Dold"
  echo ""
  neofetch --ascii_distro "$Dold"
 ;;
 2)
  echo ""
  echo "$(tput bold)Displayed Distro: $Dsmall"
  echo ""
  neofetch --ascii_distro "$Dsmall"
esac

#=================================================================================================================================================================== #
