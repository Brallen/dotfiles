#!/usr/bin/env bash
# I believe there are a few ways to do this:
#
#    3. My new favourite way: as @clot27 says, you can provide nixos-rebuild with a path to the config, allowing it to be entirely inside your dotfies, with zero bootstrapping of files required.
#       `nixos-rebuild switch -I nixos-config=path/to/configuration.nix`

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

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes with the generation metadata
git commit -am "$current"

# Back to where you were
popd

# Notify all OK!
echo 'NixOS Rebuilt OK!'
