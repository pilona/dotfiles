" TODO: Refactor?
function! s:fixup_molokai()
    " Default pale visual selection not readable.
    highlight Visual ctermbg=cyan ctermfg=black guibg=cyan guifg=black
    " Comments less readable than some people desire
    "highlight Comment ctermfg=grey guifg=grey
endfunction

autocmd ColorScheme molokai call s:fixup_molokai()
if colors_name == "molokai"
    call s:fixup_molokai()
endif
