return {
  file = function(filename)
    local realpath = vim.fn.stdpath("config") .. "/" .. filename
    vim.api.nvim_exec("source " .. realpath, nil)
  end,
}
