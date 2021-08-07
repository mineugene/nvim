--[[
-- File name:      lua/post/compe.lua
-- Last modified:  (2021-Jul-30)
-- Description:    configuration of LSP autocomplete on loaded.
]]

local Config = {}
--[[ my_config(.co_setup)
-- co_setup: arguments to pass into setup call
]]
local my_config = {
  co_setup = {
    enabled = true,
    autocomplete = true,
    preselect = "disable",
    throttle_time = 64,
    source_timeout = 96,
    resolve_timeout = 640,
    incomplete_delay = 384,
    max_abbr_width = 96,
    max_kind_width = 96,
    max_menu_width = 96,
    documentation = {
      max_width = 128,
      min_width = 64,
      max_height = math.floor(vim.o.lines * 0.3),
      min_height = 1,
    },
    source = {
      path = true,
      buffer = true,
      nvim_lsp = true,
      nvim_lua = true,
    },
  },
}

function Config:create(o)
  o = o or {}
  setmetatable(o, self)

  o.config = function()
    require("compe").setup(o.co_setup)
  end

  return o
end

return Config:create(my_config)
