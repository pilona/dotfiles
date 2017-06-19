" Start from 1, not 0, because wraparound is confusing, even if 0 is closer to
" the right/dominant hand.
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
let g:startify_bookmarks = [{'.': '.'}]
let g:startify_change_to_vcs_root = 1
let g:startify_commands = [
    \ { 'u': ['Update plugins', 'PluginUpdate'] },
    \ { 'U': ['Unicode table', 'UnicodeTable'] },
    \ { 'd': ['Digraph table', 'help digraph-table'] },
    \ { '+': ['Clipboard', 'normal eV"+p'] },
    \ { '*': ['Selection', 'normal eV"*p'] },
    \ ]
    "\ { 't': ['NeoVim terminal', 'terminal'] }

"command -nargs=0 E :Startify<CR>
command -nargs=0 Sp :split +Startify<CR>
command -nargs=0 VSp :vsplit +Startify<CR>
command -nargs=0 Tp :tabnew +Startify<CR>
