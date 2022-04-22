local util = require("utility")

if
  vim.g.colorscheme ~= nil
  and util.try_require(vim.g.colorscheme_module or vim.g.colorscheme).is_loaded()
then
  vim.api.nvim_command("colorscheme " .. vim.g.colorscheme)
else
  vim.api.nvim_command("colorscheme default")
end
