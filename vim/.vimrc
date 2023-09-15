syntax on
set nocompatible
set noshowmode
set mouse=a
set autoread
filetype off

set omnifunc=syntaxcomplete#Complete
set scrolloff=5
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:$,precedes:«,extends:»

" Highlight matches after pressing '*'
set hlsearch

" Disable default mapping for command history buffer
" I keep accidently hitting this and it is annoying.
nnoremap q: <NOP>
nnoremap q? <NOP>
nnoremap q/ <NOP>

" Airline
let g:airline_theme='deus'
set ttimeoutlen=50

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.maxlinenr=''
" don't display current git branch, takes up too much space
let g:airline_section_b=''
" simplify position-section: only show current-line, column, and total lines
let g:airline_section_z='%l:%v/%L% '

" Limelight
let g:limelight_conceal_ctermfg = 'DarkGrey'

" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|node_modules$\|.angular$\|dist\|log\|tmp$\|.idea$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

let g:ctrlp_show_hidden = 1

" Make the window higher
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:15'

" Autocompletion in command mode
set wildmenu
set wildmode=longest:full,full

filetype plugin indent on

set colorcolumn=80
highlight ColorColumn ctermbg=5
set tabstop=4


let g:zenburn_transparent = 1
colorscheme zenburn
highlight Normal ctermbg=NONE
highlight LineNr ctermbg=NONE

" https://vimhelp.org/terminal.txt.html#terminal-size-color
highlight Terminal ctermbg=NONE

let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
    " Also make middle section of modeline transparent
    "
    " Default is set here:
    " https://github.com/vim-airline/vim-airline/blob/5f5e00faad728f12f9ca9d9200208d8a39fd60f4/autoload/airline/themes.vim#L55
    let a:palette.normal.airline_term = [ '#9cffd3', '#202020', 85, 'NONE']
endfunction

" Force continous line gutters between splits
highlight VertSplit ctermbg=NONE ctermfg=8 cterm=NONE term=NONE gui=NONE guifg=NONE guibg=NONE
set fillchars+=vert:\│

" Map NerdTree to a dedicated shortcut
map <C-n> :NERDTreeToggle<CR>

let NERDTreeWinSize = 45

" Toggle distraction free mode
" Silent removes the ':Goyo' from the command buffer
map <silent> <C-g> <Esc>:Goyo<CR>
imap <C-g> <Esc>:Goyo<CR>

function! s:goyo_leave()
    " Leaving goyo somehow removes transparency.
    " Explitly make stuff transparent again here.
    highlight Normal guibg=NONE ctermbg=NONE
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()

autocmd FileType python setlocal completeopt-=preview

" Space menu with which-key
" - https://github.com/liuchengxu/vim-which-key#installation
" - https://jay-baker.com/posts/vim-1-which-key/
let mapleader = " "
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

let g:which_key_map = {}

let g:which_key_map['g'] = [ ':Goyo', 'goyo' ]
let g:which_key_map['n'] = [ ':NERDTreeToggle', 'nerdtree' ]
let g:which_key_map['b'] = [ ':CtrlPBuffer', 'buffers' ]
let g:which_key_map[' '] = [ ':CtrlP', 'fuzzy find' ]

let g:which_key_map.f = {
      \ 'name': '+files',
      \ 'r' : [ ':CtrlPMRU', 'recent' ],
      \ 'f' : [ ':NERDTreeFind', 'reveal in tree' ],
      \ }

let g:which_key_map.o = {
      \ 'name': '+open',
      \ 'q' : [ ':copen', 'open-quickfix' ],
      \ }

let g:which_key_map.w = {
      \ 'name': '+window',
      \ 'w' : [ '<C-w>w<CR>', 'next' ],
      \ 'j' : [ '<C-w>j<CR>', 'down' ],
      \ 'J' : [ '<C-w>J<CR>', 'move down' ],
      \ 'k' : [ '<C-w>k<CR>', 'up' ],
      \ 'K' : [ '<C-w>K<CR>', 'move up' ],
      \ 'h' : [ '<C-w>h<CR>', 'left' ],
      \ 'H' : [ '<C-w>H<CR>', 'move left' ],
      \ 'l' : [ '<C-w>l<CR>', 'right' ],
      \ 'L' : [ '<C-w>L<CR>', 'move right' ],
      \ 's' : [ '<C-w>s<CR>', 'vertical-split' ],
      \ 'v' : [ '<C-w>v<CR>', 'horiztonal-split' ],
      \ '=' : [ '<C-w>=<CR>', 'balance windows' ],
      \ }

let g:which_key_map.t = {
    \ 'name': '+toggles',
    \ 'l' : [ ':set number!', 'show/hide line numbers' ],
    \ 'w' : [ ':set wrap!', 'wrap lines' ],
    \ 'c' : [ ':set list!', 'show/hide hidden characters' ],
    \ }

call which_key#register('<Space>', "g:which_key_map")

" Reselect visual selection after indentation
vnoremap < <gv
vnoremap > >gv

" Avoid 'old text in clipboard' when pasting multiple times in visual mode
" https://vi.stackexchange.com/questions/25259/clipboard-is-reset-after-first-paste-in-visual-mode
xnoremap <expr> p '"0p'
xnoremap <expr> P '"0P'

" Make gutter transparent
highlight SignColumn ctermbg=NONE
highlight GitGutterAdd    guifg=#009900 ctermfg=2 ctermbg=NONE
highlight GitGutterChange guifg=#bbbb00 ctermfg=3 ctermbg=NONE
highlight GitGutterDelete guifg=#ff2222 ctermfg=1 ctermbg=NONE

autocmd BufNewFile,BufRead Jenkinsfile* setfiletype groovy

