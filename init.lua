local util = require("utility")

--[ bootstrap ]
util:bootstrap({
  "https://github.com/wbthomason/packer.nvim",
}).packer()

--[ globals ]
vim.g.colorscheme = "tokyonight"

--[ general configuration ]
util.source.file_iter({ "autocommands.vim" })
util.try_require({ "options", "keymaps" }).load()

--[ plugins configuration ]
util.try_require("plugins").depends_on({ "packer" }).load()
