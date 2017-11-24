" TODO: Send patch upstream to map only in Ruby files, and to use
"       <Buffer> <LocalLeader>
let g:vimrubocop_keymap = 1
"let g:vimrubocop_keymap = 0
"autocmd FileType ruby nnoremap <Buffer> <LocalLeader>ru :silent RuboCop<CR>
let g:vimrubocop_rubocop_cmd = '~/.gem/ruby/2.4.0/bin/rubocop'
