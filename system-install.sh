#!/bin/sh
# Install system config files
DOTFILES_DIR="$HOME/.dotfiles"

echo "Setup Pacman Configuration"
sudo cp $DOTFILES_DIR/system/etc/pacman.conf /etc/pacman.conf

echo "Install udev rules"
sudo cp $DOTFILES_DIR/system/udev/backlight.rules /etc/udev/rules.d/backlight.rules
sudo udevadm control --reload-rules
