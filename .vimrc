filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'bling/vim-airline'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'paranoida/vim-airlineish'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'godlygeek/tabular'
Plugin 'mbbill/undotree'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'ap/vim-css-color'
Plugin 'majutsushi/tagbar'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'https://github.com/thinca/vim-visualstar'

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
set spelllang=en_ca
"set spelllang=fr_ca
set cscopetag cscoperelative

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
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_extensiosn = ['tag', 'mixed']

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"let g:ycm_register_as_syntastic_checker = 0

let g:syntastic_check_on_open            = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_balloons          = 1

iabbrev Teh The
iabbrev teh the

cabbrev W w
cabbrev Q q

map Y y$

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
map <Leader>w :%s/\s\+$//<CR>
