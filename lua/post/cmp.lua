--[[
-- File name:      lua/post/compe.lua
-- Description:    configuration of LSP autocomplete on loaded.
]]

local cmp = require("cmp")
local settings = {
  enabled = true,
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
}

cmp.setup(settings)

local util = require("utility")
local autopairs_trigger = util.try_require("nvim-autopairs.completion.cmp").load()

if autopairs_trigger then
  -- autopair plugin setup
  cmp.event:on("confirm_done", autopairs_trigger.on_confirm_done())
end
