#!/bin/bash
DOTFILES_DIR="$HOME/.dotfiles"

# Do Symlinking.
ln -sfv $DOTFILES_DIR/git/.gitconfig ~/.gitconfig
ln -sfv $DOTFILES_DIR/zsh/.zshrc ~/.zshrc
ln -sfv $DOTFILES_DIR/pulse/client.conf ~/.config/pulse/client.conf
ln -sfv $DOTFILES_DIR/locale.conf ~/locale.conf
ln -sfv $DOTFILES_DIR/.tmux.conf ~/.tmux.conf
ln -sfv $DOTFILES_DIR/.editorconfig ~/.editorconfig
ln -sfv $DOTFILES_DIR/feh/themes ~/.config/feh/themes
ln -sfv $DOTFILES_DIR/feh/keys ~/.config/feh/keys
stow alacritty zathura newsboat


mkdir ~/.IdeaIC2018.1/config/colors
cd $DOTFILES_DIR/intellij
for file in `find . -type f -name \* -print`
do
    ln -sfv $DOTFILES_DIR/$file ~/.IdeaIC2018.1/config/$file
done

ln -sfv $DOTFILES_DIR/bin/markdown-all.sh ~/bin/markdown-all.sh

ln -sfv $DOTFILES_DIR/vim/.vimrc ~/.vimrc
