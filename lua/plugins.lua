local plugins = {
  ["nvim-treesitter/nvim-treesitter"] = {
    -- see `:help nvim-treesitter-intro`
    event = "BufReadPost",
    config = function()
      require("post.treesitter")
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    -- see `:help lspconfig`
    config = function()
      require("post.lspconfig")
    end,
  },
  ["hrsh7th/nvim-cmp"] = {
    -- see `:help nvim-cmp`
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
    config = function()
      require("post.cmp")
    end,
  },
  ["nvim-telescope/telescope.nvim"] = {
    -- see `:help telescope`
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("post.telescope")
    end,
  },
  ["numToStr/Comment.nvim"] = {
    -- motions to comment code
    config = function()
      require("Comment").setup()
    end,
  },
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {
    -- commentstring option setter based on cursor position
    ft = {
      "css",
      "html",
      "javascript",
      "javascriptreact",
      "scss",
      "typescript",
      "typescriptreact",
    },
  },
  ["tpope/vim-surround"] = {
    -- motions to delete/change/add parentheses/quotes/XML-tags
  },
  ["tpope/vim-repeat"] = {
    -- repeat supported plugin maps
  },
  ["lewis6991/gitsigns.nvim"] = {
    -- see `:help gitsigns`
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("post.gitsigns")
    end,
  },
  ["norcalli/nvim-colorizer.lua"] = {
    -- background/foreground text colorizer for hex codes
    event = "BufReadPre",
    config = function()
      require("colorizer").setup()
    end,
  },
  ["folke/which-key.nvim"] = {
    -- a keybind completion legend
    config = function()
      require("which-key").setup()
    end,
  },
  ["cocopon/iceberg.vim"] = {
    -- bluish color scheme
    config = function()
      require("post.colorscheme").set("iceberg")
    end,
  },
  ["folke/tokyonight.nvim"] = {
    -- color scheme ported from Visual Studio Code TokyoNight theme
    config = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_italic_comments = false
      vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
      require("post.colorscheme").set("tokyonight")
    end,
  },
}

return require("packer").startup({
  function(use)
    --[[ plugin manager
    -- `:help packer-introduction`
    ]]
    use({ "wbthomason/packer.nvim" })

    -- [ plugins ]
    for plug, load_config in pairs(plugins) do
      use(vim.tbl_extend("error", load_config, { plug }))
    end
  end,
  config = {
    ensure_dependencies = true,
    transitive_disable = true,
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
      working_sym = "#",
      error_sym = "1",
      done_sym = "0",
      removed_sym = "-",
      moved_sym = "~",
      header_sym = "─",
      show_all_info = true,
    },
    log = { level = "warn" },
  },
})
