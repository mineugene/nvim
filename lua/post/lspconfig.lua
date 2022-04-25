--[[
-- File name:      lua/post/lspconfig.lua
-- Description:    post-processes for configuring language servers once it has
--   been loaded. Servers are listed in the local my_servers table.
]]

local util = require("utility")
local nvim_lspconfig = require("lspconfig")

--[[ settings(.common | .server_names | .except_params)
-- common:          common parameters to all setup calls
-- server_names:    manually installed language servers
-- except_params:   custom arguments to be passed to setup calls
]]

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
local omnisharp_bin = util.home_dir .. ".local/omnisharp/OmniSharp"
local pid_nvim = vim.fn.getpid()

local settings = {
  common = {
    on_attach = require("on-attach.lspconfig"),
  },
  server_names = {
    "sumneko_lua",
    "vimls",
    "omnisharp",
    "pylsp",
  },
  except_params = {
    ["sumneko_lua"] = {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = runtime_path,
          },
          diagnostics = {
            enable = true,
            disable = { "different-requires", },
            globals = { "vim" },
          },
          workspace = {
            library = { vim.api.nvim_get_runtime_file("", true) },
            useGitIgnore = true,
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    },
    ["omnisharp"] = {
      cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid_nvim) }
    }
  },
}

-- setup language servers
for _, ls in ipairs(settings.server_names) do
  local except = settings.except_params[ls] or {}
  local args = vim.tbl_extend("force", settings.common, except)

  nvim_lspconfig[ls].setup(args)
end
