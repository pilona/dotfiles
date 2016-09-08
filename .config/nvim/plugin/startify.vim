let g:startify_bookmarks = [{'.': '.'}]
let g:startify_change_to_vcs_root = 1
let g:startify_commands = [
    \ { 'u': ['Update plugins', 'PluginUpdate'] },
    \ { 'U': ['Unicode table', 'UnicodeTable'] },
    \ { 't': ['NeoVim terminal', 'terminal'] }
    \ ]

"command -nargs=0 E :Startify<CR>
command -nargs=0 Sp :split +Startify<CR>
command -nargs=0 VSp :vsplit +Startify<CR>
command -nargs=0 Tp :tabnew +Startify<CR>
