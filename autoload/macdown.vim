let s:chrome_load = expand('<sfile>:p:h:h').'/bin/chrome_load'
let s:chrome_close = expand('<sfile>:p:h:h').'/bin/chrome_close'

function! macdown#preview(programme, dest, ...) abort
  let b:macdown_dest = a:dest
  if a:0 == 2
    let list = getline(a:1, a:2)
  else
    let list = getline(1, '$')
  endif
  let tmp = tempname()
  call writefile(list, tmp)
  let title = expand('%:t')
  let commands = ['cat ' . tmp . '|'
              \. a:programme . ' ' . title . '>' . a:dest . ' 2>&1'
              \, s:chrome_load . '  file://' . a:dest]
  let execute_file = tempname()
  call writefile(commands, execute_file)
  if exists('*vimproc#system')
    call vimproc#system('bash ' . execute_file . ' &')
  else
    let output =  system('bash ' . execute_file)
    if v:shell_error && output !=# ""
      echohl Error | echon output | echohl None
      return
    endif
  endif
endfunction

function! macdown#closeTab(buf)
  let dest = getbufvar(a:buf, 'macdown_dest')
  if empty(dest) | return | endif
  let output =  system(s:chrome_close . ' file://' . dest)
  if v:shell_error && output !=# ""
    echohl Error | echon output | echohl None
    return
  endif
endfunction
