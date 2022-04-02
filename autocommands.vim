" Auto-generate packer_compiled.lua on write event to lua/plugins.lua
augroup packer_autocompile
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END

" Terminal mode configuration of behaviour
augroup terminal_defaults
  autocmd!
  autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" Quit LspInfo floating menu with 'q'
augroup lspinfo_quit
  au!
  au FileType lspinfo nnoremap <silent> <buffer> q :q<CR>
augroup END

" Always re-draw from beginning for accurate syntax highlight
" (see `:help syn-sync`)
augroup accurate_syntax_highlight
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END
