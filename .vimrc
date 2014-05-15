filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'edkolev/promptline.vim'
Bundle 'edkolev/tmuxline.vim'
Bundle 'paranoida/vim-airlineish'
Bundle 'tomasr/molokai'
Bundle 'altercation/vim-colors-solarized'
Bundle 'godlygeek/tabular'
Bundle 'mbbill/undotree'
Bundle 'tommcdo/vim-exchange'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'michaeljsmith/vim-indent-object'

filetype plugin indent on
syntax on

if has("gui_running")
    set guifont=Terminus\ 14
    set guioptions=
    set background=dark
    colorscheme solarized
else
    colorscheme molokai
    let g:airline_theme = 'airlineish'
endif

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set autoindent smartindent
set hlsearch
set wildmenu
set wildmode=longest:full
set wmh=0
set laststatus=2
set foldmethod=syntax
set hidden
set incsearch
set autoread

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
" TODO: Show buffer tabline when no tabs and when multiple buffers
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#whitespace#checks = ['indent', 'trailing']

" Don't override external colour scheme choice upon startup
let g:airline#extensions#tmuxline#enabled = 0

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_working_path_mode = 'c'
let mapleader=','
