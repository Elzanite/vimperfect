if exists('g:loaded_vimperfect')
  finish
endif

" Prevents user flags from interfering with plugin
let s:save_cpo = &cpoptions
set cpo&vim

function! Vimperfect()
    " Makes it so plugin is updated after changes, removed when not in dev environment
    if exists("g:vimperfect_dev")
        lua for k in pairs(package.loaded) do if k:match("^vimperfect") then package.loaded[k] = nil end end
    end

    lua require('vimperfect').vimperfect()
endfun

command! Vimperfect :call Vimperfect()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_vimperfect = 1
