--[[
-- File name:      lua/post/telescope.lua
-- Last modified:  (2021-Aug-03)
-- Description:    telescope configuation settings and customized methods.
]]
--

local Config = {}
-- see :h telescope.setup
local my_config = {
  defaults = {
    prompt_prefix = ":find ",
    selection_caret = "▐▶ ",
    entry_prefix = "▐  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      height = 0.32,
      width = 0.90,
      scroll_speed = 3,
      horizontal = {
        mirror = false,
        preview_cutoff = 160,
        prompt_position = "bottom",
      },
    },
    file_ignore_patterns = {
      "node_modules",
    },
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    path_display = {},
    set_env = {
      ["COLORTERM"] = "truecolor",
    },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = { ["<C-d>"] = "delete_buffer" },
        n = { ["<C-d>"] = "delete_buffer" },
      },
    },
  },
}

function Config:create(o)
  o = o or {}
  setmetatable(o, self)

  o.config = function()
    require("telescope").setup(o)
  end

  o.ls = function()
    local builtin = require("telescope.builtin")
    if os.execute("git rev-parse --is-inside-work-tree 1>/dev/null 2>&1") == 0 then
      return builtin.git_files()
    end
    return builtin.find_files()
  end

  return o
end

return Config:create(my_config)
