" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

nnoremap <silent><buffer> <F7>
  \ :call <SID>compile(b:cc, b:cflags, b:src_file, b:obj_file)<CR>
nnoremap <silent><buffer> <F5> :call <SID>run(b:obj_file)<CR>

let b:cc = executable("clang") ? "clang" : "gcc"
let b:cflags = "-std=c11 -O3 -Wall"
let b:src_file = expand("%:p")
let b:obj_file = expand("%:p:r") . ".o"

" Compile single source file into an executable object file
function! s:compile(cc, cflags, src, obj) abort
  if !executable(a:cc)
    echoerr "No C compiler was found."
  endif

  execute "!" . printf("%s %s %s -o %s", a:cc, a:cflags, a:src, a:obj)
endfunction

function! s:run(ofile) abort
  let l:obj = expand("%:p:r") . ".o"

  call s:create_term_buffer()
  execute "term " . printf("%s", a:ofile)
  startinsert
endfunction

" Create a new split window, resized relative to the parent window size
function! s:create_term_buffer() abort
  let [w_height, w_width] = [winheight(0), winwidth(0)]
  let l:textwidth = &l:textwidth != 0 ? &l:textwidth : 78

  set splitbelow splitright
  if w_height < w_width && w_width > (textwidth + 5)*2
    vnew
  else
    new
    execute "resize " . winheight(0)*3/5
  endif
endfunction
