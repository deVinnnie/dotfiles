#!/bin/bash
DOTFILES_DIR="$HOME/.dotfiles"

# Do Symlinking.
ln -sfv $DOTFILES_DIR/git/.gitconfig ~/.gitconfig
ln -sfv $DOTFILES_DIR/zsh/.zshrc ~/.zshrc
ln -sfv $DOTFILES_DIR/geany/geany.conf ~/.config/geany/geany.conf
ln -sfv $DOTFILES_DIR/locale.conf ~/locale.conf
ln -sfv $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sfv $DOTFILES_DIR/.editorconfig ~/.editorconfig

ln -sfv $DOTFILES_DIR/atom/config.cson ~/.atom/config.cson
ln -sfv $DOTFILES_DIR/atom/keymap.cson ~/.atom/keymap.cson

cd $DOTFILES_DIR/intellij
for file in `find . -type f -name \* -print`
do
    ln -sfv $DOTFILES_DIR/$file ~/.IntelliJIdea2017.1/config/$file
done

ln -sfv $DOTFILES_DIR/bin/idea ~/bin/idea
ln -sfv $DOTFILES_DIR/bin/markdown-all.sh ~/bin/markdown-all.sh
