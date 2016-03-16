" FIXME: Somehow differentiate jumble of backgrounded jobs and the last exit
"        code. Currently, both of same colour.
" TODO: See what battery warning looks like.
" TODO: Colourize mode slize.
" TODO: Port vi mode slice to bash.
" TODO: Move vi mode slice out of ~/.zshrc and into somewhere else, or push
"       upstream.
let g:promptline_preset = { 'a' : [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
                          \ 'b' : [ promptline#slices#user() ],
                          \ 'c' : [ promptline#slices#cwd() ],
                          \ 'z' : [ '$vim_mode' ],
                          \ 'warn' : [ promptline#slices#last_exit_code() ] }
