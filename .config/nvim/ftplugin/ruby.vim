" String (quoted)
let b:surround_{char2nr("q")} = "%q(\r)"
let b:surround_{char2nr("Q")} = "%Q(\r)"
" Symbol
" Conflicts with surround.vim s for space
"let b:surround_{char2nr("s")} = "%s(\r)"
let b:surround_{char2nr("S")} = "%S(\r)"
" String (word) array
" FIXME: Conflicts with w/W movements
"let b:surround_{char2nr("w")} = "%w(\r)"
"let b:surround_{char2nr("W")} = "%W(\r)"
" Symbol array
let b:surround_{char2nr("i")} = "%i(\r)"
let b:surround_{char2nr("I")} = "%I(\r)"
" Regular expression
let b:surround_{char2nr("r")} = "%r(\r)"
let b:surround_{char2nr("R")} = "%R(\r)"
" Not %x, because it's unsafe. DO NOT SHELL OUT IN GOOD CODE.

" Interpolation (pound)
let b:surround_{char2nr("#")} = "#{\r}"

let b:surround_{char2nr("-")} = "<<-\1heredoc delimiter: \1\r\1\1"
let b:surround_{char2nr("~")} = "<<~\1heredoc delimiter: \1\r\1\1"
