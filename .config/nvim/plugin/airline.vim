let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
" TODO: Show buffer tabline when no tabs and when multiple buffers
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'long']
let g:airline_theme = 'airlineish'

" Don't override external colour scheme choice upon startup
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#ycm#enabled = 1
