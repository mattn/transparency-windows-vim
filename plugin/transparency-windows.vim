if &cp || (exists('g:loaded_transparency_windows_vim') && g:loaded_transparency_windows_vim)
  finish
endif
let g:loaded_transparency_windows_vim = 1

if !(has('win32') || has('win64') || has('gui_running'))
  finish
endif

let s:dll = globpath(&rtp, 'vimtweak.dll')
if len(s:dll) == 0
  finish
endif

function! s:Transparency(v)
  call libcallnr(s:dll, 'SetAlpha', 255-a:v) 
endfunction

augroup transparency_windows
  autocmd!
  autocmd FocusGained * call s:Transparency(20)
  autocmd FocusLost * call s:Transparency(50)
augroup END
