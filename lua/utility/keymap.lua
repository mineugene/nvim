return {
  setter = function(bufnr, mode, lhs, rhs, opts)
    if type(rhs) == "function" then
      opts.callback = rhs
      rhs = vim.api.nvim_replace_termcodes("<Nop>", false, false, true)
    end

    if bufnr == nil then
      vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    else
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end
  end,
}
