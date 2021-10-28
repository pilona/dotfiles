autocmd TermOpen,TermEnter term://* startinsert
autocmd TermLeave term://* stopinsert
nnoremap <C-t> :sp +terminal<CR>
nnoremap <C-s-t> :tabnew +terminal<CR>
