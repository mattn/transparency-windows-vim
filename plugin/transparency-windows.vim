scriptencoding utf-8

if &cp || (exists('g:loaded_transparency_windows_vim') && g:loaded_transparency_windows_vim)
  finish
endif

let g:loaded_transparency_windows_vim = 1

if exists('g:Transparency_FocusGained')
	let s:Transparency_FocusGained = g:Transparency_FocusGained
else
	let s:Transparency_FocusGained = 20
endif

if exists('g:Transparency_FocusLost')
	let s:Transparency_FocusLost = g:Transparency_FocusLost
else
	let s:Transparency_FocusLost = 50
endif

if !has('gui_running') || (!has('win32') && !has('win64'))
  finish
endif

let s:dll = get(g:, 'vimtweak_dll_path', '')
if empty(s:dll)
  let s:dll = get(split(globpath(&rtp, has('win64') ? 'vimtweak64.dll' : 'vimtweak32.dll'), '\n'), 0, '')
  if empty(s:dll)
    finish
  endif
endif

function! s:Transparency(v)
  call libcallnr(s:dll, 'SetAlpha', 255-a:v) 
endfunction

function! s:Install(flag)
  augroup TransparencyWindows
    autocmd!
    if a:flag =~# '^\(1\|[tT]rue\|[yY]es\)$'
      autocmd FocusGained * call s:Transparency(s:Transparency_FocusGained)
      autocmd FocusLost * call s:Transparency(s:Transparency_FocusLost)
    endif
  augroup END
endfunction

command! -nargs=1 Transparency call <SID>Install(<f-args>)
command! -nargs=1 TransparencyChange call <SID>Transparency(<args>)

Transparency Yes
