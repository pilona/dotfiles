" Dirty hack
nmap     <Space>  [fzf]
nnoremap          [fzf]        <Nop>

" TODO: :Lines!, :GFiles!, Rg!
nnoremap <silent> [fzf]<Space> :Rg!<CR>
nnoremap <silent> [fzf]b       :Buffers!<CR>
nnoremap <silent> [fzf]c       :Commands!<CR>
nnoremap <silent> [fzf]f       :Files!<CR>
nnoremap <silent> [fzf]g       :Commits!<CR>
nnoremap <silent> [fzf]h       :Helptags!<CR>
nnoremap <silent> [fzf]l       :Locate!<Space>
nnoremap <silent> [fzf]m       :Maps!<CR>
nnoremap <silent> [fzf]r       :History!<CR>
nnoremap <silent> [fzf]s       :Snippets!<CR>
nnoremap <silent> [fzf]t       :Tags!<CR>
nnoremap <silent> [fzf]w       :Windows!<CR>
nnoremap <silent> [fzf]:       :History:!<CR>
nnoremap <silent> [fzf]/       :History/!<CR>
" TODO: nnoremap <silent> [fzf]u       <insert><Plug>(UnicodeFuzzy)

let g:fzf_preview_window = ''

"" Per https://github.com/junegunn/fzf/blob/master/README-VIM.md#examples
"" An action can be a reference to a function that processes selected lines
"function! s:build_quickfix_list(lines)
"  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
"  copen
"  cc
"endfunction
"
"let g:fzf_action = {
"  \ 'ctrl-q': function('s:build_quickfix_list'),
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-x': 'split',
"  \ 'ctrl-v': 'vsplit' }
"
"" Customize fzf colors to match your color scheme
"" - fzf#wrap translates this to a set of `--color` options
"let g:fzf_colors =
"\ { 'fg':      ['fg', 'Normal'],
"  \ 'bg':      ['bg', 'Normal'],
"  \ 'hl':      ['fg', 'Comment'],
"  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"  \ 'hl+':     ['fg', 'Statement'],
"  \ 'info':    ['fg', 'PreProc'],
"  \ 'border':  ['fg', 'Ignore'],
"  \ 'prompt':  ['fg', 'Conditional'],
"  \ 'pointer': ['fg', 'Exception'],
"  \ 'marker':  ['fg', 'Keyword'],
"  \ 'spinner': ['fg', 'Label'],
"  \ 'header':  ['fg', 'Comment'] }
