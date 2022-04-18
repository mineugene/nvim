local util = require("utility")

--[ bootstrap ]
util:bootstrap({
  "https://github.com/wbthomason/packer.nvim",
}).packer()

--[ globals ]
vim.g.colorscheme = "tokyonight"

--[ general configuration ]
util.try_require({ "autocmd", "options", "keymaps" }).load()

--[ plugins configuration ]
util.try_require("impatient").load() -- recommended to load before plugins
util.try_require("plugins").depends_on({ "packer" }).load()
