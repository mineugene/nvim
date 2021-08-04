" Modify existing filetypes
augroup Filetypes
augroup END

" Terminal mode configuration
augroup Terminal
  au!
  au TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
  au TermOpen * startinsert
  au TermOpen * setlocal nonumber norelativenumber
augroup END

" Override formatoptions set in $VIMRUNTIME/ftplugin/vim.vim
augroup FmtOptions
  au!
  au BufNewFile,BufReadPost * setlocal formatoptions=jq
augroup END

" Exit LspInfo command floating window with 'q'
augroup LspInfo
  au!
  au FileType lspinfo nnoremap <silent> <buffer> q :q<CR>
augroup END

