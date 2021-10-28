set colorcolumn=80
" http://stackoverflow.com/questions/2447109/showing-a-different-background-colour-in-vim-past-80-characters

highlight Tab ctermbg=red guibg=red
match ExtraWhitespace /[^\t]\zs\t/
setlocal listchars=tab:␉─,
setlocal list
