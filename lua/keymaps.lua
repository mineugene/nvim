--[[
-- File name:      lua/keymaps.lua
-- Last modified:  (2021-Aug-02)
-- Description:    keymaps for start plugins are defined here. Keymaps for
--   opt (lazy-loaded) plugins may also be defined in their respective
--   post-configuation lua files (lua/post/).
--]]


local DEFAULT_OPTS = { silent=true, noremap=true }
local keymaps_n = {
  -- normal
  ['\\'] = "<Cmd>split<CR><Cmd>exe 'resize '.(winheight(0)*3/5)<CR><Cmd>terminal<CR>",
  ["<Leader>h"] = "<Cmd>nohls<CR>",
  -- telescope
  ["gd"] = "<Cmd>Telescope lsp_definitions<CR>",
  ["gi"] = "<Cmd>Telescope lsp_implementations<CR>",
  ["gr"] = "<Cmd>Telescope lsp_references<CR>",
  ["<Leader>ff"] = "<Cmd>lua require('post.telescope').ls()<CR>",
  ["<Leader>fb"] = "<Cmd>Telescope buffers<CR>",
  ["<Leader>fg"] = "<Cmd>Telescope live_grep<CR>",
  ["<Leader>fh"] = "<Cmd>Telescope help_tags<CR>",
}


vim.g.mapleader = ' '

for cmd,map in pairs(keymaps_n) do
  vim.api.nvim_set_keymap('n', cmd, map, DEFAULT_OPTS)
end

