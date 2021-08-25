--[[
-- File name:      lua/keymaps.lua
-- Last modified:  (2021-Aug-24)
-- Description:    keymaps for start plugins are defined here. Keymaps for
--   opt (lazy-loaded) plugins may also be defined in their respective
--   post-configuation lua files (lua/post/).
--]]

local DEFAULT_OPTS = { silent = true, noremap = true }
local keymaps_n = {
  -- normal
  ["\\"] = "<Cmd>split<CR><Cmd>exe 'resize '.(winheight(0)*3/5)<CR><Cmd>terminal<CR>",
  ["<Leader>h"] = "<Cmd>nohls<CR>",
  -- telescope
  ["<Leader>gd"] = "<Cmd>Telescope lsp_definitions<CR>",
  ["<Leader>gi"] = "<Cmd>Telescope lsp_implementations<CR>",
  ["<Leader>gr"] = "<Cmd>Telescope lsp_references<CR>",
  ["<Leader>ff"] = "<Cmd>lua require('post.telescope').ls()<CR>",
  ["<Leader>fb"] = "<Cmd>Telescope buffers<CR>",
  ["<Leader>fg"] = "<Cmd>Telescope live_grep<CR>",
  ["<Leader>fh"] = "<Cmd>Telescope help_tags<CR>",
  -- context-commentstring
  ["<Leader>gc"] = "<Cmd>lua require('ts_context_commentstring.internal').update_commentstring()<CR>",
}

vim.g.mapleader = " "

for cmd, map in pairs(keymaps_n) do
  vim.api.nvim_set_keymap("n", cmd, map, DEFAULT_OPTS)
end
