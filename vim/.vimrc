syntax on
set nocompatible
set noshowmode
set mouse=a
filetype off

set omnifunc=syntaxcomplete#Complete
set scrolloff=5

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
Plugin 'tpope/vim-commentary'
call vundle#end()

filetype plugin indent on

set colorcolumn=80
highlight ColorColumn ctermbg=5
set tabstop=4


let g:zenburn_transparent = 1
colorscheme zenburn
highlight Normal ctermbg=NONE
highlight LineNr ctermbg=NONE

" Force continous line gutters between splits
highlight VertSplit ctermbg=NONE ctermfg=8 cterm=NONE term=NONE gui=NONE guifg=NONE guibg=NONE
set fillchars+=vert:\│

" Map NerdTree to a dedicated shortcut
map <C-n> :NERDTreeToggle<CR>

" Toggle distraction free mode
map <C-g> <Esc>:Goyo<CR>
imap <C-g> <Esc>:Goyo<CR>

function! s:goyo_leave()
    " Leaving goyo somehow removes transparency.
    " Explitly make stuff transparent again here.
    highlight Normal guibg=NONE ctermbg=NONE
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()

autocmd FileType python setlocal completeopt-=preview

" Reselect visual selection after indentation
vnoremap < <gv
vnoremap > >gv

