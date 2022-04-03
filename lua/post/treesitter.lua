--[[
-- File name:      lua/post/treesitter.lua
-- Description:    contains list of treesitter configurations to update and
--   setup on loaded.
]]

local settings = {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  matchup = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

require("nvim-treesitter.configs").setup(settings)
vim.api.nvim_command("TSUpdate")
