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
" lua-vim api extension
let s:vim_api = luaeval('require("utility").api')

" Compile single source file into an executable object file
function! s:compile(cc, cflags, src, obj) abort
  if !executable(a:cc)
    echoerr "No C compiler was found."
  endif

  execute "!" . printf("%s %s %s -o %s", a:cc, a:cflags, a:src, a:obj)
endfunction

function! s:run(ofile) abort
  let l:obj = expand("%:p:r") . ".o"

  let bufnr = s:vim_api.nvim_create_buf()
  call s:vim_api.nvim_resize_win()
  call s:vim_api.nvim_open_term(bufnr, printf("%s", a:ofile))
  startinsert
endfunction
