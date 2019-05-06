#!/bin/sh
# Install system config files
DOTFILES_DIR="$HOME/.dotfiles"

echo "Setup Pacman Configuration"
sudo cp $DOTFILES_DIR/system/etc/pacman.conf /etc/pacman.conf

