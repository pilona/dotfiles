let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

let g:ycm_path_to_python_interpreter = '/usr/bin/python3'

" TODO: Group
" Since YCM unconditionally remaps <Tab> on VimEnter, we need to remap <Tab>
" on every new buffer here. Fortunately, YCM doesn't map again because of the
" filetype blacklist.
autocmd FileType text inoremap <buffer> <Tab> <C-N>
autocmd FileType text inoremap <buffer> <S-Tab> <C-P>
