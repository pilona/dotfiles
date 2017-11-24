" The "Vim HAMLLint" plugin runs haml_lint and displays the results in Vim.
"
" Derived from https://github.com/ngmy/vim-rubocop,
" Copyright (c) 2013 Yuta Nagamiya
"
" Author:    Alex Pilon
" ----------------------------------------------------------------------------

if exists('g:loaded_vimhamllint') || &cp
  finish
endif
let g:loaded_vimhamllint = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:vimhamllint_hamllint_cmd')
  let g:vimhamllint_hamllint_cmd = 'haml-lint '
endif

" Options
if !exists('g:vimhamllint_config')
  let g:vimhamllint_config = ''
endif

if !exists('g:vimhamllint_extra_args')
  let g:vimhamllint_extra_args = ''
endif

if !exists('g:vimhamllint_keymap')
  let g:vimhamllint_keymap = 1
endif

let s:hamllint_switches = ['-i', '--include-linter',
                          \'-x', '--exclude-linter',
                          \'-r', '--reporter']

function! s:HAMLLintSwitches(...)
  return join(s:hamllint_switches, "\n")
endfunction

function! s:HAMLLint(current_args)
  let l:extra_args     = g:vimhamllint_extra_args
  let l:filename       = @%
  let l:hamllint_cmd    = g:vimhamllint_hamllint_cmd
  let l:hamllint_opts   = ' '.a:current_args.' '.l:extra_args
  if g:vimhamllint_config != ''
    let l:hamllint_opts = ' '.l:hamllint_opts.' --config '.g:vimhamllint_config
  endif

  let l:hamllint_output = system(l:hamllint_cmd.l:hamllint_opts.' '.l:filename)
  " TODO: Make more robust
  " TODO: Set errorformat instead
  let l:hamllint_output = substitute(l:hamllint_output, ' \[\([WC]\)\]', ': \1:', 'g')
  echo l:hamllint_output
  let l:hamllint_output = substitute(l:hamllint_output, '\\"', "'", 'g')
  let l:hamllint_results = split(l:hamllint_output, "\n")
  if len(l:hamllint_results) > 0
    cgete l:hamllint_results
    copen
  endif
  " Shortcuts taken from Ack.vim - git://github.com/mileszs/ack.vim.git
  exec "nnoremap <silent> <buffer> q :ccl<CR>"
  exec "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
  exec "nnoremap <silent> <buffer> T <C-W><CR><C-W>TgT<C-W><C-W>"
  exec "nnoremap <silent> <buffer> o <CR>"
  exec "nnoremap <silent> <buffer> go <CR><C-W><C-W>"
  exec "nnoremap <silent> <buffer> h <C-W><CR><C-W>K"
  exec "nnoremap <silent> <buffer> H <C-W><CR><C-W>K<C-W>b"
  exec "nnoremap <silent> <buffer> v <C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t"
  exec "nnoremap <silent> <buffer> gv <C-W><CR><C-W>H<C-W>b<C-W>J"
endfunction

command! -complete=custom,s:HAMLLintSwitches -nargs=? HAMLLint :call <SID>HAMLLint(<q-args>)

" Shortcuts for HAMLLint
if g:vimhamllint_keymap == 1
  " Use same map as RuboCop because it's more convenient in such projects,
  " since you're a templating language for Ruby.
  autocmd FileType haml nnoremap <Buffer> <LocalLeader>ru :silent HAMLLint<CR>
endif

let &cpo = s:save_cpo
let g:vimhamllint_hamllint_cmd = '~/.gem/ruby/2.4.0/bin/haml-lint'
