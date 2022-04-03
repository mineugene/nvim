return {
  setter = function(bufnr, mode, lhs, rhs, opts)
    if bufnr then
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    else
      vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
  end,
}
