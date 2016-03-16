filetype off

set rtp+=~/.config/nvim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'bling/vim-airline'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'paranoida/vim-airlineish'
" TODO: Compare to 'https://github.com/chriskempson/base16-vim'
"                  (http://chriskempson.github.io/base16/)
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
" TODO: Compare to 'https://github.com/junegunn/vim-easy-align'
Plugin 'godlygeek/tabular'
Plugin 'mbbill/undotree'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'kien/ctrlp.vim'
" TODO: Compare to 'https://github.com/tpope/vim-commentary'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'ap/vim-css-color'
Plugin 'chrisbra/csv.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'jooize/vim-colemak'
"Plugin 'glts/vim-textobj-comment'
"Plugin 'Mark'
"Plugin 'itchyny/lightline.vim'
"Plugin 'jmcantrell/vim-virtualenv'
"Plugin 'chriskempson/tomorrow-theme'
"Plugin 'chriskempson/base16-vim'
"Plugin 'mhinz/vim-signify'
Plugin 'chrisbra/NrrwRgn'
"Plugin 'int3/vim-extradite'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'https://github.com/thinca/vim-visualstar'
" Maybe:
Plugin 'https://github.com/terryma/vim-multiple-cursors'
"Plugin 'https://github.com/ntpeters/vim-better-whitespace'
"Plugin 'https://github.com/szw/vim-ctrlspace'
Bundle 'https://github.com/rking/ag.vim'
"Bundle 'https://github.com/mileszs/ack.vim'
"Bundle 'vim-scripts/visualrepeat'
"Bundle 'https://github.com/nathanaelkane/vim-indent-guides'
" Nah:
"Plugin 'https://github.com/tpope/vim-eunuch'
"Plugin 'https://github.com/rhysd/clever-f.vim'
Plugin 'https://github.com/kien/rainbow_parentheses.vim'
"Plugin 'https://github.com/spolu/dwm.vim'

filetype plugin indent on
syntax on

if has("gui_running")
    set guifont=Terminess\ Powerline\ 14
    set guioptions=
    set background=dark
    colorscheme solarized
else
    "let g:rehash256 = 1 " too pale
    colorscheme molokai
endif

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set shiftround
set autoindent
set hlsearch
set wildmenu
set wildmode=longest:full
set wmh=0
set laststatus=2
set foldmethod=syntax
set hidden
set incsearch
set autoread
" TODO: Mappings for cycling through these
set spelllang=en_ca
"set spelllang=fr_ca  " FIXME: Region not supported
" TODO: Figure out how to shorten mode switching time
"set timeoutlen=0 ttimeoutlen=0
set cscopetag cscoperelative
set diffopt+=vertical
set undofile

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"let g:ycm_register_as_syntastic_checker = 0

" TODO: Fix/set *Leader bindings so that these can be used. These are wanted
"       because entering command mode and typing out commands in full is
"       wrong.
map <LocalLeader>tc :tabnew %<CR>
map <LocalLeader>td :tabclose<CR>

nnoremap Y y$

nnoremap - <C-W>-
nnoremap + <C-W>+
nnoremap _ <C-W>_
" Keep the = mapping though because it's very useful.

nnoremap Q q:i

cnoremap <C-O> <Up>
" TODO: How to map without killing completion or a better mapping?
"cnoremap <C-I> <Down>

" TODO: Remap CTRL-J, <NL>, and CTRL-N because in normal mode they aren't
" useful in the presence of just 'j'.
" FIXME: Not repeatable?
" FIXME: :silent is not really silent
nnoremap <C-K> :silent move .-2<CR>
nnoremap <C-J> :silent move .+1<CR>
vnoremap <C-K> :silent move '<.-2<CR>
vnoremap <C-J> :silent move '>.+1<CR>
" TODO: [<C-> and <C->] mappings
nnoremap ]<C-J> :silent move .+1<CR>==
nnoremap [<C-K> :silent move .-2<CR>==
" TODO: More reliable <Esc>
"inoremap <C-J> <Esc>:silent m .+1<CR>==gi
"inoremap <C-K> <Esc>:silent m .-2<CR>==gi
vnoremap ]<C-J> :silent move '>.+1<CR>gv=gv
vnoremap [<C-K> :silent move '<.-2<CR>gv=gv

nnoremap ZA :qa!<CR>

" Stolen from Damian Conway
nnoremap <silent> <BS> :nohlsearch<CR>
nnoremap S :%s//g<Left><Left>

" TODO: <C-S-T> instead? Oddly enough, what's below is almost somehow
"       sensible.
nnoremap <C-n> :tabnew<CR>
nnoremap <C-p> :-tabnew<CR>

" Conflict with Pmenu bindings
"inoremap <C-e> <C-o><C-e>
"inoremap <C-y> <C-o><C-y>
" But what if I want to scroll rest of screen while inside Pmenu?
inoremap <expr> <C-e> pumvisible() ? "\<C-e>" : "\<C-o>\<C-e>"
inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "\<C-o>\<C-y>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" <Return> is already not that far and ingrained muscle memory for creating a
" new line—not that I couldn't unlearn it, yet this is right beside the
" backwards delete—<C-H>, so convenient and somehow oddly sensible, and kind
" of reminds of you of normal J doesn't it?
inoremap <C-j> <Del>
