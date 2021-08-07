--[[
-- File name:      lua/post/treesitter.lua
-- Last modified:  (2021-Jul-29)
-- Description:    contains list of treesitter configurations to update and
--   setup on loaded.
]]

local Config = {}
--[[ my_config(.ts_setup)
-- ts_setup: arguments to pass into setup call.
]]
local my_config = {
  ts_setup = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "html",
      "javascript",
      "json",
      "lua",
      "python",
      "tsx",
      "typescript",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    matchup = { enable = true },
  },
}

function Config:create(o)
  o = o or {}
  setmetatable(o, self)

  self.__index = self
  o.config = function()
    require("post.treesitter").update()
    require("nvim-treesitter.configs").setup(o.ts_setup)
  end
  o.update = function()
    vim.api.nvim_command("TSUpdate")
  end

  return o
end

return Config:create(my_config)
