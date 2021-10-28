unlet b:current_syntax
syn include @SQL syntax/sql.vim
" Cannot deal with anything that comes after the heredoc.
" E.g.,
"
" execute <<~'SQL'
" This will work.
" SQL
"
" execute(<<~'SQL, whatever) + whatever
" Everything including the comma on is also highlighted as SQL, not Ruby.
" SQL
syn region sqlHeredoc matchgroup=rubyStringDelimiter start=/<<\(['"]\)SQL\1\ze/hs=s+2 end=/^\s*SQL$/ keepend contains=@SQL
syn region sqlHeredoc matchgroup=rubyStringDelimiter start=/<<\%([-~]\|\)\(['"]\?\)SQL\1\ze/hs=s+3 end=/^\s*SQL$/ keepend contains=@SQL
let b:current_syntax = "ruby"
