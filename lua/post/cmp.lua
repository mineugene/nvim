--[[
-- File name:      lua/post/compe.lua
-- Description:    configuration of LSP autocomplete on loaded.
]]

local Config = {}
-- see :h cmp
local cmp = require("cmp")
--[[ setup_params(.settings)
-- settings: arguments to pass into setup call
]]
local setup_params = {
  settings = {
    enabled = true,
    mapping = {
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
    }),
  },
}

function Config:create(o)
  o = o or {}
  setmetatable(o, self)

  o.config = function()
    require("cmp").setup(o.settings)
  end

  return o
end

return Config:create(setup_params)
