set colorcolumn=80
" http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim-past-80-characters

" Don't add CR at end, since we want to be able to enter command-line
" arguments.
nmap <F2> :!python %<Space>
nmap <F3> :!python -m pdb %<Space>
vmap <F2> :w !python %<Space>
