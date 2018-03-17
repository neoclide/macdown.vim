let s:chrome_load = expand('<sfile>:p:h:h').'/bin/chrome_load'
let s:chrome_close = expand('<sfile>:p:h:h').'/bin/chrome_close'
let s:job = 0

function! macdown#preview(prog, dest, ...) abort
  let b:macdown_dest = a:dest
  let start = a:0 == 2 ? a:1 : 1
  let end = a:0 == 2 ? a:2 : '$'
  if exists('*jobstart')
    call s:Macdown_Exec_Async_Nvim(a:prog, a:dest, start, end)
  elseif exists('*job_start')
    call s:Macdown_Exec_Async_Vim(a:prog, a:dest, start, end)
  else
    let list = getline(start, end)
    let tmp = tempname()
    call writefile(list, tmp)
    let title = expand('%:t')
    let commands = ['cat ' . tmp . '|'
                \. a:prog . ' ' . title . ' &>' . a:dest
                \, s:chrome_load . '  file://' . a:dest]
    let execute_file = tempname()
    call writefile(commands, execute_file)
    let output =  system('bash ' . execute_file)
    if v:shell_error && output !=# ""
      echohl Error | echon output | echohl None
      return
    endif
  endif
endfunction

function! s:Macdown_Exec_Async_Nvim(prog, dest, start, end)
  let lines = getline(a:start, a:end)
  let out = []
  let err = []
  let cmd = a:prog . ' ' . expand('%t')
  if s:job
    call jobstop(s:job)
  endif
  let job = jobstart(cmd, {
    \ 'on_stdout': {job_id, data, event -> extend(l:out, data)},
    \ 'on_stderr': {job_id, data, event -> extend(l:err, data)},
    \ 'on_exit': {job_id, status, event -> s:Macdown_Job_Nvim_Exit(job_id, status, a:dest, l:out, l:err)},
    \ })
  if job == -1
    echoerr 'Failed to start job: '. a:prog . ' is not executeable'
  elseif job == 0
    echoerr 'Failed to start job: invalid arguments' 
  else
    let s:job = job
  endif
  call jobsend(l:job, l:lines)
  call jobclose(l:job, 'stdin')
endfunction

function! s:Macdown_Job_Nvim_Exit(job, status, dest, out, err)
  if s:job != a:job | return | endif
  let s:job = 0
  for msg in a:err
    echoerr msg
  endfor
  call writefile(a:out, a:dest)
  call jobstart(s:chrome_load . ' file://' . a:dest)
endfunction

function! s:Macdown_Exec_Async_Vim(prog, dest, start, end)
  let cmd = a:prog . ' ' . expand('%t')
  if s:job
    call job_stop(s:job)
  endif
  let l:channel = job_start(cmd, {
    \ 'in_io': 'buffer',
    \ 'in_buf': bufnr('%'),
    \ 'in_top': a:start,
    \ 'in_bot': a:end,
    \ 'out_io': 'file',
    \ 'out_name': a:dest,
    \ 'close_cb': {channel -> s:Macdown_Job_Vim_Exit(channel, a:dest)}
    \ })
  let g:c = l:channel
endfunction

function! s:Macdown_Job_Vim_Exit(channel, dest)
  "if s:job != a:channel | return | endif
  let g:a = 333
  let s:job = 0
  call job_start(s:chrome_load . ' file://' . a:dest)
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
