--[[
-- File name:      lua/options.lua
-- Description:    https://vimhelp.org/options.txt.html
]]

require("utility").option.set_iter({
  background = "dark",
  backup = false,
  cmdheight = 1,
  colorcolumn = "80",
  complete = ".,w,b,u,t,i",
  completeopt = "menuone,noselect",
  cursorcolumn = false,
  cursorline = true,
  encoding = "utf-8",
  equalalways = false,
  expandtab = true,
  gdefault = true,
  guicursor = table.concat({
    "n-v-c-sm:block",
    "n-v-c-sm:blinkwait700-blinkon400-blinkoff250",
    "i-ci-ve:ver25",
    "i-ci-ve:blinkwait700-blinkon400-blinkoff250",
    "r-cr-o:hor20",
    "r-cr-o:blinkwait700-blinkon400-blinkoff250",
  }, ","),
  hidden = true,
  hlsearch = true,
  ignorecase = true,
  incsearch = true,
  laststatus = 2,
  list = true,
  listchars = "tab:>·,trail:·",
  number = true,
  relativenumber = true,
  path = ".,/usr/include,**", -- recursive find (**)
  scrolloff = 4,
  shiftwidth = 2,
  shortmess = vim.api.nvim_get_option("shortmess") .. "c",
  showcmd = true,
  showmode = true,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  softtabstop = 2,
  splitbelow = true,
  splitright = true,
  statusline = table.concat({
    "[%n] ", -- buffer number
    "%<%f ", -- truncate point & filename
    "%=",
    "%-7{''.(&fenc!=''?&fenc:&enc).''} ", -- fileencoding | encoding
    "%-6{&ff} ", -- fileformat(dos,unix,mac)
    "%l(%L):%-4c %03p%% ", -- line(total):cols percent
    "%m%r%w ", -- modified/readonly/preview
  }),
  synmaxcol = 256,
  tabstop = 2,
  termguicolors = true,
  textwidth = 0,
  updatetime = 200,
  wildmenu = true,
  wrap = true,
})
