--[[
-- File name:      lua/keymaps.lua
-- Description:    keymaps for start plugins are defined here. Keymaps for
--   opt (lazy-loaded) plugins may also be defined in their respective
--   post-configuation lua files (lua/post/).
--]]

local DEFAULT_OPTS = { noremap = true, silent = true }
local nkeymaps = {
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

local function create_buf_term()
  local bufnr = util.api.nvim_create_buf()
  local win_width, win_height = unpack(util.api.nvim_win_get_dim())
  local textwidth = vim.api.nvim_get_option("textwidth")

  textwidth = textwidth == 0 and 78 or textwidth
  if win_height < win_width and win_width > 2 * (textwidth + 5) then
    vim.cmd("vsplit") -- split right-half
  else
    vim.cmd("split | resize " .. (win_height * 1 / 3)) -- split bottom-third
  end
  -- enter terminal mode
  vim.api.nvim_win_set_buf(0, bufnr)
  vim.cmd("terminal")
end

util.keymap.set(util.mapmode.NORMAL, "<Leader><Bslash>", create_buf_term, DEFAULT_OPTS)
