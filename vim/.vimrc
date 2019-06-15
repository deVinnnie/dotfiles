syntax on

set nocompatible
set noshowmode
filetype off

" Airline
let g:airline_theme='deus'
set ttimeoutlen=50

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()

filetype plugin indent on

set colorcolumn=80
highlight ColorColumn ctermbg=5

