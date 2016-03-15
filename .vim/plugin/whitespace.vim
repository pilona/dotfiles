highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
nnoremap <Leader>w :%s/\s\+$//<CR>
vnoremap <Leader>w :s/\s\+$//<CR>
