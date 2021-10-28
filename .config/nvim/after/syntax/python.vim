unlet b:current_syntax

syn include @SQL syntax/sql.vim
syntax region sqlPythonString
     \ matchgroup=SpecialComment
     \ start=~r'''\%(\%(--[^\r\n]*[\r\n]\)\|\_s\)*\%(ALTER\|BEGIN\|CALL\|COMMENT\|COMMIT\|CONNECT\|COPY\|CREATE\|DELETE\|DROP\|END\|EXPLAIN\|GRANT\|INSERT\|LOCK\|REFRESH\|RESET\|REVOKE\|ROLLBACK\|SELECT\|SET\|TRUNCATE\|UPDATE\|WITH\)~rs=s+4
     \ end=+'''+
     \ contains=@SQL

let b:current_syntax = "python"
