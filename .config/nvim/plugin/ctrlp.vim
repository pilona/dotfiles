let g:ctrlp_map = '<Nop>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'cr'
let g:ctrlp_extensions = ['tag', 'mixed', 'quickfix']

nmap     <Space>  [ctrlp]
nnoremap          [ctrlp]        <Nop>
" TODO: <Space><Space> is buffer or mixed?
nnoremap <silent> [ctrlp]<Space> :CtrlPMixed<CR>
nnoremap <silent> [ctrlp]b       :CtrlPBuffer<CR>
nnoremap <silent> [ctrlp]f       :CtrlP<CR>
nnoremap <silent> [ctrlp]m       :CtrlPMixed<CR>
nnoremap <silent> [ctrlp]r       :CtrlPMRU<CR>
nnoremap <silent> [ctrlp]t       :CtrlPBufTagAll<CR>
nnoremap <silent> [ctrlp]q       :CtrlPQuickfix<CR>
