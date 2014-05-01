filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'

filetype plugin indent on

set laststatus=2

let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
