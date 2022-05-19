--[[
-- File name:      lua/post/treesitter.lua
-- Description:    contains list of treesitter configurations to update and
--   setup on loaded.
]]

local settings = {
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "cpp",
    "css",
    "dockerfile",
    "haskell",
    "help",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "latex",
    "lua",
    "make",
    "markdown",
    "ninja",
    "perl",
    "php",
    "phpdoc",
    "python",
    "regex",
    "rust",
    "scheme",
    "scss",
    "toml",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
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
