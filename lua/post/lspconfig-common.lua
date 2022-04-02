--[[
-- File name:      lua/post/lspconfig-common.lua
-- Description:    common utility functions to setup language servers
]]

local on_attach = function(_, bufnr)
  -- completion triggered by ^X^O
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- keymap definitions
  local keymap_opts = { noremap = true, silent = true }
  local keymaps_n = {
    ["gD"] = "<Cmd>lua vim.lsp.buf.declaration()<CR>",
    ["K"] = "<Cmd>lua vim.lsp.buf.hover()<CR>",
    ["<C-k>"] = "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
    ["<Space>wa"] = "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    ["<Space>wr"] = "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    ["<Space>wl"] = "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    ["<Space>D"] = "<Cmd>lua vim.lsp.buf.type_definition()<CR>",
    ["<Space>rn"] = "<Cmd>lua vim.lsp.buf.rename()<CR>",
    ["<Space>ca"] = "<Cmd>lua vim.lsp.buf.code_action()<CR>",
    ["<Space>e"] = "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>",
    ["[d"] = "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
    ["]d"] = "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
    ["<Space>q"] = "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
    ["<Space>f"] = "<Cmd>lua vim.lsp.buf.formatting()<CR>",
  }
  -- keymap processing
  for m, cmd in pairs(keymaps_n) do
    vim.api.nvim_buf_set_keymap(bufnr, "n", m, cmd, keymap_opts)
  end
end

return on_attach
