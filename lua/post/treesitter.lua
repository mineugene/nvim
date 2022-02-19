--[[
-- File name:      lua/post/treesitter.lua
-- Description:    contains list of treesitter configurations to update and
--   setup on loaded.
]]

local Config = {}
--[[ my_config(.ts_setup)
-- ts_setup: arguments to pass into setup call.
]]
local my_config = {
  settings = {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    matchup = { enable = true },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  },
}

function Config:create(o)
  o = o or {}
  setmetatable(o, self)

  self.__index = self
  o.config = function()
    require("post.treesitter").update()
    require("nvim-treesitter.configs").setup(o.settings)
  end
  o.update = function()
    vim.api.nvim_command("TSUpdate")
  end

  return o
end

return Config:create(my_config)
