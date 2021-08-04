vim.api.nvim_command("colorscheme iceberg")
vim.api.nvim_command("au ColorScheme * hi Normal ctermbg=none guibg=none")

vim.api.nvim_command("au ColorScheme * hi LspDiagnosticsDefaultHint guifg=#7759B4")
vim.api.nvim_command("au ColorScheme * hi LspDiagnosticsDefaultError guifg=#CC517A")
vim.api.nvim_command("au ColorScheme * hi LspDiagnosticsDefaultWarning guifg=#C57339")
vim.api.nvim_command("au ColorScheme * hi LspDiagnosticsDefaultInformation guifg=#3F83A6")

