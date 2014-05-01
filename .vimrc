filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'
Bundle 'tomasr/molokai'
Bundle 'altercation/vim-colors-solarized'

filetype plugin indent on
syntax on

if has("gui_running")
    set background=dark
    colorscheme solarized
else
    colorscheme molokai
endif

set laststatus=2

let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
