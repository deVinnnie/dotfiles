#!/bin/sh
DOTFILES_DIR=`pwd`

echo '' >> ~/.bashrc
echo '# Parameters for the dotfiles project' >> ~/.bashrc
echo 'export DOTFILES='$DOTFILES_DIR >> ~/.bashrc
cat $DOTFILES_DIR/.bashrc >> ~/.bashrc

git config --global core.excludesfile $DOTFILES_DIR/.gitignore_global

# Create secret.sh
SECRET_FILE=secret.sh
touch $SECRET_FILE
read -p "Please enter the path of your projects directory: " PROJECTS_DIR
echo "export PROJECTS_DIR=$PROJECTS_DIR" >> $SECRET_FILE
