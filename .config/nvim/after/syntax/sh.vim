unlet b:current_syntax

" TODO: See sh-embed, sh-awk

" Syntax def in conflict with all the others. Why?
"syn include @DOT syntax/dot.vim
syn include @SQL syntax/sql.vim
syn include @AWK syntax/awk.vim
syn include @SH $VIMRUNTIME/syntax/sh.vim

"syntax region sqlShHereDoc
"     \ matchgroup=SpecialComment
"     \ start=~'\%(\%(--[^\r\n]*[\r\n]\)\|\_s\)*\%(ALTER\|BEGIN\|CALL\|COMMENT\|COMMIT\|CONNECT\|COPY\|CREATE\|DELETE\|DROP\|END\|EXPLAIN\|GRANT\|INSERT\|LOCK\|REFRESH\|RESET\|REVOKE\|ROLLBACK\|SELECT\|SET\|TRUNCATE\|UPDATE\|WITH\)~rs=s+4
"     \ end=+'+
"     \ contains=@SQL
" FIXME: Everything after the here doc delimiter is also highlighted as SQL.
"syn region shHereDocDOT matchgroup=shBeginHere start=/<<\s*\%(-\?\)\_s*\(['"]\?\)\z(\%(P\)\?DOT\)\1/ end=/^\s*\z1$/ms=e-1 keepend contains=@DOT containedin=ALL
syn region shHereDocSQL matchgroup=shBeginHere start=/<<\s*\%(-\?\)\_s*\(['"]\?\)\z(\%(P\)\?SQL\)\1/ end=/^\s*\z1$/ms=e-1 keepend contains=@SQL containedin=ALL
syn region shHereDocAWK matchgroup=shBeginHere start=/<<\s*\%(-\?\)\_s*\(['"]\?\)\z(\%(P\)\?AWK\)\1/ end=/^\s*\z1$/ms=e-1 keepend contains=@AWK containedin=ALL
syn region shHereDocSH  matchgroup=shBeginHere start=/<<\s*\%(-\?\)\_s*\(['"]\?\)\z(\%(P\)\?SH\)\1/ end='^\s*\z1$'ms=e-1 keepend contains=@SH  containedin=ALL
"syn region shHereDocSQL start=/<<\%(-\?\)['"]\?\z(P\)\?SQL['"]\?/ end=/^\z2SQL$/ keepend contains=@SQL
" TODO: AWK, SH, PYTHON

let b:current_syntax = "sh"
