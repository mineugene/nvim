--[[
-- File name:      lua/plugins.lua
-- Last modified:  (2021-Aug-10)
-- Description:    bootstrap and setup of the 'packer' plugin manager.
--   Plugin configuation files are in `lua/post/`.
--]]

--[[ BOOTSTRAP ]]
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer"

if fn.empty(fn.glob(install_path .. "/start/packer.nvim")) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  execute("packadd packer.nvim")
end

--[[ AUTO-COMPILE ]]
vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")

return require("packer").startup({
  --[[ LOAD PLUGINS ]]
  function(use)
    -- package manager
    use({ "wbthomason/packer.nvim" })

    -- bluish color scheme
    use({ "cocopon/iceberg.vim" })

    --[[ nvim-treesitter
    -- Supports syntax highlighting, code navigation, refactoring,
    -- text objects, and motions, for each individual language.
    --  :help nvim-treesitter-commands
    ]]
    use({
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      branch = "0.5-compat",
      event = "BufReadPost",
      config = function()
        require("post.treesitter").config()
      end,
    })

    --[[ nvim-lspconfig
    -- Configuration manager for builtin language server client.
    -- Automatically loads and initializes installed LSPs.
    --  :help lsp
    --  :help lspconfig
    ]]
    use({
      "neovim/nvim-lspconfig",
      opt = true,
      after = "nvim-lspinstall",
      config = function()
        require("post.lspconfig").config()
      end,
    })

    -- lsp installer
    use({
      "kabouzeid/nvim-lspinstall",
      opt = true,
      event = { "BufReadPre", "BufNewFile" },
    })

    -- lsp auto-complete
    use({
      "hrsh7th/nvim-compe",
      opt = true,
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("post.compe").config()
      end,
    })

    -- python language server
    use({
      "davidhalter/jedi-vim",
      opt = true,
      ft = { "python" },
    })

    --[[ nvim-telescope
    -- Uses the power of the moon to fuzzy-find over directories.
    --   :help telescope.nvim
    ]]
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
      },
      config = function()
        require("post.telescope").config()
      end,
    })

    --[[ neoformat
    -- Auto-formatter that selects from a variety of formatters depending on the
    --   filetype of the current buffer.
    -- See `autoload/neoformat/formatters/{filetype}.vim` for configuration.
    ]]
    use({
      "sbdchd/neoformat",
      opt = true,
      cmd = "Neoformat",
    })

    --[[ vim-gitgutter
    -- Shows a git diff in the sign column. Previews, stages, and
    --   undo's individual hunks; and stages partial hunks.
    --   A hunk text object is also provided.
    ]]
    use({ "airblade/vim-gitgutter" })

    -- performant colourizer for hex-codes, name-codes, and css
    use({
      "norcalli/nvim-colorizer.lua",
      event = "BufReadPre",
      config = function()
        require("colorizer").setup()
      end,
    })

    -- displays all common base representations for a given number
    use({
      "glts/vim-radical",
      requires = { "glts/vim-magnum" },
    })

    -- markdown previewer with browser
    use({
      "iamcco/markdown-preview.nvim",
      opt = true,
      ft = { "markdown" },
      run = "cd app;yarn install",
      cmd = "MarkdownPreview",
    })

    -- extension to vim `%` command
    use({
      "andymass/vim-matchup",
      opt = true,
      after = "nvim-treesitter",
    })

    -- efficiency enhancements
    use({ "tpope/vim-commentary" })
    use({ "tpope/vim-surround" })
    use({ "tpope/vim-repeat" })
    use({ "inkarkat/vim-ReplaceWithRegister" })

    -- html tag auto-close completion
    use({
      "alvan/vim-closetag",
      opt = true,
      ft = { "html" },
    })

    -- commentstring setter on CursorHold events
    use({
      "JoosepAlviste/nvim-ts-context-commentstring",
      opt = true,
      ft = {
        "css",
        "handlebars",
        "html",
        "javascript",
        "javascriptreact",
        "scss",
        "typescript",
        "typescriptreact",
      },
    })
    --[[ which-key
    -- A command legend in the form of a popup. It shows suggestions to
    --   complete a key binding. Also shows marks and register contents.
    --]]
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup()
      end,
    })
  end,

  --[[ CUSTOM PACKER CONFIGURATION ]]
  ensure_dependencies = true,
  transitive_disable = true,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
      working_sym = "W",
      error_sym = "1",
      done_sym = "0",
      removed_sym = "-",
      moved_sym = "M",
      header_sym = "─",
      show_all_info = true,
    },
  },
  log = { level = "warn" },
})
