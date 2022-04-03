return {
  set = function(colorscheme)
    -- global colorscheme set from init.lua
    if vim.g.colorscheme == colorscheme then
      vim.api.nvim_command("colorscheme " .. colorscheme)
    end
  end,
}
