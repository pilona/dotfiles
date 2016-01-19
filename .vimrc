filetype off

set rtp+=~/.vim/bundle/vundle/
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
" TODO: Mappings for cycling through these
set spelllang=en_ca
"set spelllang=fr_ca  " FIXME: Region not supported
" TODO: Figure out how to shorten mode switching time
"set timeoutlen=0 ttimeoutlen=0
set cscopetag cscoperelative
set diffopt+=vertical

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
" TODO: Show buffer tabline when no tabs and when multiple buffers
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#whitespace#checks = ['indent', 'trailing']

" Don't override external colour scheme choice upon startup
let g:airline#extensions#tmuxline#enabled = 0

" FIXME: Somehow differentiate jumble of backgrounded jobs and the last exit
"        code. Currently, both of same colour.
" TODO: See what battery warning looks like.
" TODO: Colourize mode slize.
" TODO: Port vi mode slice to bash.
" TODO: Move vi mode slice out of ~/.zshrc and into somewhere else, or push
"       upstream.
let g:promptline_preset = { 'a' : [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
                          \ 'b' : [ promptline#slices#user() ],
                          \ 'c' : [ promptline#slices#cwd() ],
                          \ 'z' : [ '$vim_mode' ],
                          \ 'warn' : [ promptline#slices#jobs(),
                                     \ promptline#slices#last_exit_code(),
                                     \ promptline#slices#battery() ] }

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

cabbrev W w!
cabbrev Q q!
cabbrev X x!

" TODO: Fix/set *Leader bindings so that these can be used. These are wanted
"       because entering command mode and typing out commands in full is
"       wrong.
map <LocalLeader>tc :tabnew %<CR>
map <LocalLeader>td :tabclose<CR>

map Y y$

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
map <Leader>w :%s/\s\+$//<CR>

"http://vim.wikia.com/wiki/Autoloading_Cscope_Database
"http://stackoverflow.com/questions/12243233/how-to-auto-load-cscope-out-in-vim
"http://derekingrouville.ca/2012/cscope-will-change-the-way-you-code/
"http://vim.sourceforge.net/scripts/script.php?script_id=157
"http://dslab.lzu.edu.cn:8080/members/zhangwei/doc/cscope-HOWTO.txt
"http://www.vim.org/scripts/script.php?script_id=51

" Bart's things
" TODO: Add jargon file to dictionaries
" TODO: Add timestamp shorthand
" TODO: Add signature shorthand
" TODO: Highlight profanity, etc
" TODO: Mapping to move line with cursor, like when I often want to move a
"       line up
" TODO: tagbar instead of taglist
" TODO: See if NERDTree is worth much
" TODO: Rebuild vim with Python **3** support
" TODO: Ambiwidth investigation, esp. for em-dashes
" TODO: Remove encoding and line ending part of airline, as well as percentage
"       part, and L/N symbol.
"
" Automatically leave insert mode
"au CursorHoldI * stopinsert
"au InsertEnter * let updaterestore=&updatetime | set updatetime=2000
"au InsertLeave * let &updatetime=updaterestore
