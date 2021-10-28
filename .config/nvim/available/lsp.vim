Plugin 'neovim/nvim-lspconfig'
Plugin 'vhakulinen/gnvim-lsp'

" You also must:
" sudo pacman -S jedi-language-server
" or
" sudo pacman -S python-lsp-server
" sudo pacman -S vscode-{css,html,json}-languageserver
" sudo pacman -S yaml-language-server


lua << EOF
  local on_attach = function(client)
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end
  require('lspconfig').pylsp.setup({ on_attach = on_attach })
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- Disable signs
      signs = false,
    }
  )
EOF

set completeopt-=preview
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-X><C-o>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-x><C-o>"
nnoremap <silent> K <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap gd <Cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gD <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gI <Cmd>lua vim.lsp.buf.references()<CR>
nnoremap gi <Cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap go <Cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap gr <Cmd>lua vim.lsp.buf.rename()<CR>
" TODO: type definition

" TODO: https://github.com/hrsh7th/nvim-cmp for incremental completion
" TODO: https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
" TODO: https://github.com/ray-x/lsp_signature.nvim
