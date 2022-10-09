#!/bin/sh
# See:
# - :help packages
# - https://bigfont.ca/notes-on-vims-native-package-manager/
# - https://opensource.com/article/20/2/how-install-vim-plugins
mkdir -p ~/.vim/pack/plugins/start
cd ~/.vim/pack/plugins/start
git clone https://github.com/editorconfig/editorconfig-vim.git || true
git clone https://github.com/vim-airline/vim-airline.git || true
git clone https://github.com/vim-airline/vim-airline-themes.git || true
git clone https://github.com/scrooloose/nerdtree.git || true
git clone https://github.com/ryanoasis/vim-devicons.git || true
git clone https://github.com/airblade/vim-gitgutter.git || true
git clone https://github.com/junegunn/goyo.vim.git || true
git clone https://github.com/junegunn/limelight.vim.git || true
git clone https://github.com/tpope/vim-commentary.git || true
git clone https://github.com/tpope/vim-surround.git || true
git clone https://github.com/ctrlpvim/ctrlp.vim.git || true
git clone https://github.com/liuchengxu/vim-which-key.git || true
git clone https://github.com/iberianpig/tig-explorer.vim.git || true
