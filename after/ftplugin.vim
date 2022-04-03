" Modify existing filetypes
augroup Filetypes
augroup END

" Override formatoptions
augroup format_override
  autocmd!
  autocmd BufNewFile,BufReadPost * setlocal formatoptions-=cro fo+=jq
augroup END
