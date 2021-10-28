filetype off

" Bypass pyenv or virtualenv. Just use the user-local package, rather than
" expecting the current Python env to be sane, especially if being developed
" in, moreso if foreign.
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

set rtp+=~/.config/nvim/bundle/vundle/
call vundle#rc()

Plugin 'altercation/vim-colors-solarized'
Plugin 'chrisbra/Recover.vim'
Plugin 'chrisbra/unicode.vim'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'gmarik/vundle'
Plugin 'godlygeek/tabular'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'justinmk/vim-dirvish'
Plugin 'mbbill/undotree'
Plugin 'mhinz/vim-startify'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'ngmy/vim-rubocop'
Plugin 'nvie/vim-flake8'
Plugin 'paranoida/vim-airlineish'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'SirVer/ultisnips'
Plugin 'thinca/vim-visualstar'
Plugin 'tomasr/molokai'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

filetype plugin indent on
syntax on

if has("gui_running")
    set guifont=Terminess\ Powerline\ 14
    set guioptions=
    set background=dark
else
    if &t_Co >= 256
        "let g:rehash256 = 1 " too pale
        colorscheme molokai
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
set indentkeys-=0#
set cinkeys-=0#
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
set grepprg=rg\ --vimgrep\ --no-heading

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
let g:terminal_scrollback_buffer_size = 4096

nnoremap Y y$
nnoremap yY :%yank <C-r>=v:register<CR><CR>
nnoremap dD :%delete <C-r>=v:register<CR><CR>

nnoremap - <C-W>-
nnoremap + <C-W>+
nnoremap _ <C-W>_
nnoremap <Bar> <C-w><Bar>
" Keep the = mapping though because it's very useful.

nnoremap Q q:i

cnoremap <C-O> <Up>
" TODO: How to map without killing completion or a better mapping?
"cnoremap <C-I> <Down>

nnoremap ZA :qa!<CR>

nnoremap <silent> <Leader>t :tabs<CR>
nnoremap <silent> <Leader>b :buffers<CR>

" Stolen from Damian Conway
nnoremap <silent> <BS> :nohlsearch<CR>
nnoremap S :%s//g<Left><Left>

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

nnoremap du :silent diffupdate<CR>
