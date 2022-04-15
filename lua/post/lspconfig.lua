--[[
-- File name:      lua/post/lspconfig.lua
-- Description:    post-processes for configuring language servers once it has
--   been loaded. Servers are listed in the local my_servers table.
]]

local nvim_lspconfig = require("lspconfig")

--[[ settings(.common | .server_names | .except_params)
-- common:          common parameters to all setup calls
-- server_names:    manually installed language servers
-- except_params:   custom arguments to be passed to setup calls
]]
local settings = {
  common = {
    on_attach = require("post.lspconfig-common"),
  },
  server_names = {
    "sumneko_lua",
    "vimls",
    "pylsp",
  },
  except_params = {
    ["sumneko_lua"] = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            enable = true,
            disable = {
              "different-requires",
            },
            globals = { "vim" },
          },
          workspace = {},
          telemetry = { enable = false },
        },
      },
    },
  },
}

-- setup language servers
for _, ls in ipairs(settings.server_names) do
  local except = settings.except_params[ls] or {}
  local args = vim.tbl_extend("force", settings.common, except)

  nvim_lspconfig[ls].setup(args)
end
