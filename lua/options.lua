--[[
-- File name:      lua/options.lua
-- Last modified:  (2021-Aug-24)
-- Description:    https://vimhelp.org/options.txt.html
]]

local o = vim.opt_local
local g = vim.opt_global

--[[ GLOBAL ]]
g.background = "light"
g.backup = false
g.cmdheight = 1
g.complete = ".,w,b,u,t,i"
g.completeopt = "menuone,noselect"
g.cursorcolumn = false
g.cursorline = true
g.encoding = "utf-8"
g.equalalways = false
g.expandtab = true
g.formatoptions = "jq"
g.gdefault = true
g.guicursor = table.concat({
  "n-v-c-sm:block",
  "n-v-c-sm:blinkwait700-blinkon400-blinkoff250",
  "i-ci-ve:ver25",
  "i-ci-ve:blinkwait700-blinkon400-blinkoff250",
  "r-cr-o:hor20",
  "r-cr-o:blinkwait700-blinkon400-blinkoff250",
}, ",")
g.hidden = true
g.hlsearch = true
g.incsearch = true
g.laststatus = 2
-- stylua: ignore
g.path = ".,/usr/include,**"   -- recursive find (**)
g.scrolloff = 16
g.shiftwidth = 2
g.shortmess:append("c")
g.showcmd = true
g.showmode = true
g.smartcase = true
g.smartindent = true
g.softtabstop = 2
g.splitbelow = true
g.splitright = true
-- stylua: ignore
g.statusline = table.concat({
  "[%n] ",                                     -- buffer number
  "%<%f ",                                     -- truncate point & filename
  "%=",
  "%-7{''.(&fenc!=''?&fenc:&enc).''} ",        -- fileencoding | encoding
  "%-6{&ff} ",                                 -- fileformat(dos,unix,mac)
  "%l(%L):%-4c %03p%% ",                       -- line(total):cols percent
  "%m%r%w "                                    -- modified/readonly/preview
})
g.tabstop = 2
g.termguicolors = true
g.updatetime = 200
g.wildmenu = true

--[[ LOCAL ]]
o.colorcolumn = "81"
o.complete = ".,w,b,u,t,i"
o.expandtab = true
o.list = true
o.listchars = "tab:>·,trail:·"
o.number = true
o.relativenumber = true
o.shiftwidth = 2
o.signcolumn = "yes"
o.softtabstop = 2
o.tabstop = 2
o.wrap = true

--[[ FILETYPE ]]
vim.api.nvim_command("au FileType python setl ts=4 sw=4 sts=4 et")
vim.api.nvim_command("au FileType sh setl ts=4 sw=4 sts=4 et")
vim.api.nvim_command("au FileType javascript,cucumber,html,css setl ts=2 sw=2 sts=2 et")

--[[ LOCAL FORMATOPTIONS ]]
vim.api.nvim_command("au BufNewFile,BufReadPre * setl fo-=cro")
