#!/usr/bin/env sh

# Cd to script directory.
current_pwd="$(dirname -- "${0}")"
cd "${current_pwd}" || exit 1

# Install paru if not already installed.
if ! which paru >/dev/null 2>&1; then
	# Setup tmp paru directory.
	tmp_paru="$(mktemp -d)"
	trap 'rm -rf "${tmp_paru}"' 0 1 15

	# Install paru.
	git clone 'https://aur.archlinux.org/paru.git' "${tmp_paru}/paru"
	cd "${tmp_paru}/paru" || exit 1
	sudo makepkg --noconfirm -si || exit 1

	# Cd back to script directory.
	cd "${current_pwd}" || exit 1
fi

# Install required packages.
pkg_list="${current_pwd}/pkgs"
sed '/^#/d; s/#.*//g; /^$/d' < "${pkg_list}" | xargs -ro paru --needed -S

# Exit if stow isn't installed.
if ! which stow >/dev/null 2>&1; then
	echo 'ERROR: gnu stow binary could not be found.'
	exit 1
fi

# Symlink dotfiles with stow.
stow --adopt -d "${current_pwd}" -t "${HOME}" --ignore '^/install.sh' .

# vim:fileencoding=utf-8:foldmethod=marker
