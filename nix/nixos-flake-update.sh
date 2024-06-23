#!/usr/bin/env bash
#
# An update script that commits on a successful update and switch with flakes
set -e

# cd to your config dir
pushd ~/.dotfiles/nix/

echo "NixOS Updating..."

sudo nix flake update

# Shows your changes
git diff -U0 '*.nix'

echo "NixOS Switching ..."

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
echo 'NixOS Updated OK!'
