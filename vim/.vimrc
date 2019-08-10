syntax on

set nocompatible
set noshowmode
filetype off

" Airline
let g:airline_theme='deus'
set ttimeoutlen=50

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.maxlinenr=''

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


let g:zenburn_transparent = 1
colorscheme zenburn

" Force continous line gutters between splits
hi VertSplit ctermbg=8 guibg=bg ctermfg=bg guifg=bg
set fillchars+=vert:\│

