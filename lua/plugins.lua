--[[
-- File name:      lua/plugins.lua
-- Description:    bootstrap and setup of the 'packer' plugin manager.
--   Plugin configuation files are in `lua/post/`.
--]]

local fn = vim.fn

-- [[ bootstrap package manager ]]
local packer_loc = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_uri = "https://github.com/wbthomason/packer.nvim"
local bootstrap_success

if fn.empty(fn.glob(packer_loc)) > 0 then
  bootstrap_success = fn.system({ "git", "clone", "--depth", "1", packer_uri, packer_loc })
  vim.o.runtimepath = fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
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
      config = function()
        require("post.lspconfig").config()
      end,
    })

    -- lsp auto-complete
    use({
      "hrsh7th/nvim-cmp",
      config = function()
        require("post.cmp").config()
      end,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "petertriho/cmp-git",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
      },
    })

    -- lua language server
    use({
      "sumneko/lua-language-server",
      opt = true,
      ft = { "lua" },
      run = require("post.lua-language-server").run(),
    })

    -- python language server
    use({
      "deoplete-plugins/deoplete-jedi",
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

    if bootstrap_success then
      require("packer").sync()
    end
  end,

  --[[ custom initialization ]]
  config = {
    ensure_dependencies = true,
    transitive_disable = true,
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
    log = { level = "warn" },
  },
})
