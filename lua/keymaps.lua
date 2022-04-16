--[[
-- File name:      lua/keymaps.lua
-- Description:    keymaps for start plugins are defined here. Keymaps for
--   opt (lazy-loaded) plugins may also be defined in their respective
--   post-configuation lua files (lua/post/).
--]]

local DEFAULT_OPTS = { noremap = true, silent = true }
local nkeymaps = {
  ["<Leader><Bslash>"] = require("utility").api.nvim_create_buf_term,
  ["<Leader>h"] = "<Cmd>nohlsearch<CR>",
  -- telescope
  ["<Leader>gd"] = "<Cmd>Telescope lsp_definitions<CR>",
  ["<Leader>gi"] = "<Cmd>Telescope lsp_implementations<CR>",
  ["<Leader>gr"] = "<Cmd>Telescope lsp_references<CR>",
  ["<Leader>ff"] = "<Cmd>Telescope find_files<CR>",
  ["<Leader>fb"] = "<Cmd>Telescope buffers<CR>",
  ["<Leader>fg"] = "<Cmd>Telescope live_grep<CR>",
  ["<Leader>fh"] = "<Cmd>Telescope help_tags<CR>",
  -- context-commentstring
  ["<Leader>gc"] = "<Cmd>lua require('ts_context_commentstring.internal').update_commentstring()<CR>",
}

vim.g.mapleader = " "

local util = require("utility")
for lhs, rhs in pairs(nkeymaps) do
  util.keymap.set(util.mapmode.NORMAL, lhs, rhs, DEFAULT_OPTS)
end
