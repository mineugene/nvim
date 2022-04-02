" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Behaves mostly just like C
runtime! ftplugin/c.vim
let b:cflags = "-std=c++14 -lstdc++ -O3 -Wall"
