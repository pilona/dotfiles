highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
nnoremap <Leader>w :%s/\v\s+$//<CR>
vnoremap <Leader>w :s/\v\s+$//<CR>
