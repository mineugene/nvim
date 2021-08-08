--[[
-- File name:      lua/post/lspconfig.lua
-- Last modified:  (2021-Aug-01)
-- Description:    post-processes for configuring nvim-lspconfig once it has
--   been loaded. Servers are listed in the local my_servers table.
]]

-- see :h lspconfig
local nvim_lspconfig = require("lspconfig")
local nvim_lspinstall = require("lspinstall")
local sumneko_ls_path = vim.fn.stdpath("data")
  .. "/site/pack/packer/opt/lua-language-server"

local Config = {}
local my_config

local on_attach = function(_, bufnr)
  -- stylua: ignore start
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- stylua: ignore end

  -- completion triggered by ^X^O
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

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
    buf_set_keymap("n", m, cmd, keymap_opts)
  end
end

--[[ my_config(.ls_config | .ls_setup_args | .ls_setup_except)
-- ls_config:          manually installed language servers to setup
-- ls_setup_args:      default arguments to pass to all setup calls
-- ls_setup_except:    custom arguments to pass to a setup call
]]
my_config = {
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md for a
  --   list of all supported configurable LSPs.
  ls_config = {
    "bashls",
    "clangd",
    "cssls",
    "html",
    "jsonls",
    "pyright",
    "sumneko_lua",
    "tsserver",
    "vimls",
  },
  ls_setup_args = {
    on_attach = on_attach,
  },
  ls_setup_except = {
    ["pyright"] = {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
    },
    ["sumneko_lua"] = {
      cmd = {
        sumneko_ls_path .. "/bin/Linux/lua-language-server",
        "-E",
        sumneko_ls_path .. "/main.lua",
      },
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {},
          telemetry = { enable = false },
        },
      },
    },
  },
}

function Config:create(o)
  o = o or {}
  setmetatable(o, self)

  self.__index = self
  o.config = function()
    -- lspinstall
    nvim_lspinstall.setup()
    vim.list_extend(o.ls_config, nvim_lspinstall.installed_servers())

    -- lspconfig
    for _, ls in ipairs(o.ls_config) do
      local except = o.ls_setup_except[ls] or {}
      local args = vim.tbl_extend("force", o.ls_setup_args, except)
      nvim_lspconfig[ls].setup(args)
    end
  end

  return o
end

return Config:create(my_config)
