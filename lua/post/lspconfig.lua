--[[
-- File name:      lua/post/lspconfig.lua
-- Description:    post-processes for configuring language servers once it has
--   been loaded. Servers are listed in the local my_servers table.
]]

-- setup processing interface
local Config = {}
-- see :h lspconfig
local nvim_lspconfig = require("lspconfig")
local on_attach = require("post.lspconfig-common")
local lua_lspbin = vim.fn.stdpath("data") .. "/site/pack/packer/opt/lua-language-server/bin/"

--[[ setup_params(.common | .server_names | .except_params)
-- common:          parameters to pass to all setup calls
-- server_names:    manually installed language server names
-- except_params:   custom arguments to be passed to setup calls
]]
local setup_params = {
  common = {
    on_attach = on_attach,
  },
  server_names = {
    "sumneko_lua",
  },
  except_params = {
    ["sumneko_lua"] = {
      cmd = {
        lua_lspbin .. "lua-language-server",
        "-E",
        lua_lspbin .. "main.lua",
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
    -- setup language servers
    for _, ls in ipairs(o.server_names) do
      local except = o.except_params[ls] or {}
      local args = vim.tbl_extend("force", o.common, except)

      nvim_lspconfig[ls].setup(args)
    end
  end

  return o
end

return Config:create(setup_params)
