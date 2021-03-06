syntax on
set nocompatible
set noshowmode
set mouse=a
filetype off

set omnifunc=syntaxcomplete#Complete

" Airline
let g:airline_theme='deus'
set ttimeoutlen=50

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.maxlinenr=''

" Limelight
let g:limelight_conceal_ctermfg = 'DarkGrey'

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'davidhalter/jedi-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ryanoasis/vim-devicons'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
call vundle#end()

filetype plugin indent on

set colorcolumn=80
highlight ColorColumn ctermbg=5
set tabstop=4


let g:zenburn_transparent = 1
colorscheme zenburn

" Force continous line gutters between splits
hi VertSplit ctermbg=8 guibg=bg ctermfg=bg guifg=bg
set fillchars+=vert:\│

" Map NerdTree to a dedicated shortcut
map <C-n> :NERDTreeToggle<CR>

" Toggle distraction free mode
map <C-g> <Esc>:Goyo<CR>
imap <C-g> <Esc>:Goyo<CR>

autocmd FileType python setlocal completeopt-=preview
