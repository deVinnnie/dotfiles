#!/bin/sh
DOTFILES_DIR=`pwd`

echo 'export DOTFILES='$DOTFILES_DIR > ~/.bashrc
cat $DOTFILES_DIR/.bashrc >> ~/.bashrc
