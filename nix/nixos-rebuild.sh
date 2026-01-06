#!/usr/bin/env bash

# A rebuild script that commits on a successful build
set -e

# Edit your config
$EDITOR ~/.dotfiles/nix/configuration.nix

# cd to your config dir
pushd ~/.dotfiles/nix/

if git diff --quiet '*.nix'; then
	echo "No changes detected, exiting."
	popd
	exit 0
fi

# Autoformat your nix files
alejandra . &>/dev/null ||
	(
		alejandra .
		echo "formatting failed!" && exit 1
	)

# Shows your changes
git diff -U0 '*.nix'

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
# sudo nixos-rebuild switch -I nixos-config=./configuration.nix &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)
sudo nixos-rebuild switch --flake . &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Comment this out for now since current isnt working
# # Get current generation metadata
# current=$(nixos-rebuild list-generations | grep current)
#
# # Commit all changes with the generation metadata
# git commit -am "$current"
echo "Don't forget to commit your changes!"

# Back to where you were
popd

# Notify all OK!
echo 'NixOS Rebuilt OK!'
