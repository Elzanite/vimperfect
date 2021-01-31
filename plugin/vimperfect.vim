if exists('g:loaded_vimperfect')
  finish
endif

" Prevents user flags from interfering with plugin
let s:save_cpo = &cpoptions
set cpo&vim

command! Vimperfect lua require('vimperfect')

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_vimperfect = 1
