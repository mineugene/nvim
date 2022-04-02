local api = vim.api

return {
  list_changed = function()
    local result = {}

    for opt, info in pairs(api.nvim_get_all_options_info()) do
      if info.was_set then
        result[#result + 1] = opt
      end
    end
    return result
  end,
  setter = function(option, value)
    local info = api.nvim_get_option_info(option)

    if info.scope == "global" or info.global_local then
      api.nvim_set_option(option, value)
    elseif info.scope == "win" then
      api.nvim_win_set_option(0, option, value)
    else
      api.nvim_buf_set_option(0, option, value)
    end
  end,
}
