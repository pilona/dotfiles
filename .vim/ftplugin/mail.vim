set spell

" Move cursor past mail headers
/^$/+1

" FIXME: Make matches silent
" Fix quote markers in body:
" - bunched up quote markers
" FIXME: First pattern only fixes every other adjacent quote marker.
"        Kludged by running twice.
silent ,$substitute/>>/> >/ge
silent ,$substitute/>>/> >/ge
" - ensure trailing space after last quote marker succeeded by text
" TODO: Make magic
silent ,$substitute/^\(>\s*\)*>\([^> ]\)/\1> \2/e

" Move cursor past mail headers.
" Normally you'd think this would encourage top-posting, but I tend more often
" to cut lots of quoted text.
normal gg
/^$/+1

"call remove(g:airline#extensions#whitespace#checks, index('trailing'))
