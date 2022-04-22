local util = require("utility")

-- Auto-generate packer_compiled.lua on write event to lua/plugins.lua
--stylua: ignore
util.augroup("packer_autocompile")
  .au("BufWritePost", "plugins.lua", "source <afile> | PackerCompile")

-- Terminal mode entering/exiting behaviour and options
--stylua: ignore
util.augroup("terminal_mode_behaviour")
  .au("TermOpen", "*", "tnoremap <buffer> <Esc> <C-Bslash><C-n>")
  .au("TermOpen", "*", "startinsert")
  .au("TermOpen", "*", "setlocal nonumber norelativenumber")

-- vim.keymap.set(util.mapmode.TERMINAL, "<Esc>", "<C-Bslash><C-n>", { buffer = true })

-- Quit out of pop-up windows easily
--stylua: ignore
util.augroup("easy_way_out")
  .au("FileType", "help,lspinfo", "nnoremap <silent><buffer> q <Cmd>q<CR>")

-- Always re-draw from beginning for accurate syntax highlight at the cost of performance
--stylua: ignore
util.augroup("accurate_syntax_highlight")
  .au("BufEnter", "*", "syntax sync fromstart")
