filetype off

set rtp+=~/.config/nvim/bundle/vundle/
call vundle#rc()

Plugin 'altercation/vim-colors-solarized'
Plugin 'chrisbra/csv.vim'
Plugin 'chrisbra/NrrwRgn'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'gmarik/vundle'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mbbill/undotree'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'paranoida/vim-airlineish'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'rking/ag.vim'
Plugin 'thinca/vim-visualstar'
Plugin 'tomasr/molokai'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-capslock'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

filetype plugin indent on
syntax on

if has("gui_running")
    set guifont=Terminess\ Powerline\ 14
    set guioptions=
    set background=dark
    colorscheme solarized
else
    if &t_Co >= 256
        "let g:rehash256 = 1 " too pale
        colorscheme molokai
        " Default pale visual selection not readable.
        highlight Visual ctermbg=cyan ctermfg=black guibg=cyan guifg=black
    else
        if &diff
            colorscheme darkblue
        endif
    endif
    set fillchars+=vert:█
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
set nottimeout ttimeoutlen=-1
set cscopetag cscoperelative
set diffopt+=vertical
set undofile

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
let g:terminal_scrollback_buffer_size = 4096

nnoremap Y y$

nnoremap - <C-W>-
nnoremap + <C-W>+
nnoremap _ <C-W>_
nnoremap <Bar> <C-w><Bar>
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

nnoremap <silent> <Leader>t :tabs<CR>
nnoremap <silent> <Leader>b :buffers<CR>

" Stolen from Damian Conway
nnoremap <silent> <BS> :nohlsearch<CR>
nnoremap S :%s//g<Left><Left>

" TODO: <C-S-T> instead? Oddly enough, what's below is almost somehow
"       sensible.
nnoremap <silent> <C-n> :tabnew +Startify<CR>
nnoremap <silent> <C-p> :-tabnew +Startify<CR>

" Conflict with Pmenu bindings
"inoremap <C-e> <C-o><C-e>
"inoremap <C-y> <C-o><C-y>
" But what if I want to scroll rest of screen while inside Pmenu?
"inoremap <expr> <C-e> pumvisible() ? "\<C-e>" : "\<C-o>\<C-e>"
"inoremap <expr> <C-y> pumvisible() ? "\<C-y>" : "\<C-o>\<C-y>"
" FIXME: Conflicts with vim-endwise
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" <Return> is already not that far and ingrained muscle memory for creating a
" new line—not that I couldn't unlearn it, yet this is right beside the
" backwards delete—<C-H>, so convenient and somehow oddly sensible, and kind
" of reminds of you of normal J doesn't it?
inoremap <C-j> <C-o>J
inoremap <C-l> <Del>

" https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
