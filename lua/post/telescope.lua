local settings = {
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

require("telescope").setup(settings)

-- local telescope_builtin = require("telescope.builtin")
-- if os.execute("git rev-parse --is-inside-work-tree 1>/dev/null 2>&1") == 0 then
-- return telescope_builtin.git_files()
-- end
-- return telescope_builtin.find_files()
