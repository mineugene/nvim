local protect = require("utility.extensions.protect")
local Utility = {
  packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim",
  packer_runtime = vim.fn.stdpath("data") .. "/site/pack/*/start/*",
}

---
---Bootstrapping utilities for packer.nvim, a plugin manager for Neovim.
---
---@param self table Reference to `Utility` instance.
---@param o table Overrides.
---@return table base
function Utility.bootstrap(self, o)
  self.__index = self

  o = o or {}
  o.packer = function()
    require("utility.bootstrap")(o[1] or o.packer_uri, o.packer_path, o.packer_runtime)
  end

  return setmetatable(o, self)
end

---
---Attempts to source the given module(s), not raising an error when any module does not exist.
---
---@param o string|table
---@return table base The same `Utility` instance to chain method calls.
function Utility.try_require(o)
  if type(o) == "string" then
    local sngl_modname = o
    o = { sngl_modname }
  else
    o = o or {} -- multiple modules to require()
  end

  local _meta = {
    ---
    ---Attaches `dependencies` to the module being sourced.
    ---
    ---Expected to be chained with `Utility.try_require()`.
    ---
    ---@param dependencies table
    ---@return table base
    depends_on = function(dependencies)
      o.dependencies = dependencies
      return o
    end,
    ---
    ---Sources the module, only if it exists.
    ---
    ---Expected to be chained with `Utility.try_require()`.
    load = function()
      local mods = { unpack(o) }
      local i = 1
      repeat
        require("utility.try").configure(mods[i], i == 1 and o.dependencies or {})
        i = i + 1
      until i > #mods
    end,
  }
  return setmetatable(o, { __index = _meta })
end

Utility.source = {
  ---
  ---Sources VimL modules from stdpath('config').
  ---
  ---@param filename string
  file = function(filename)
    require("utility.source").file(filename)
  end,
  ---
  ---Sources multiple VimL modules from stdpath('config').
  ---
  ---@param filenames table
  file_iter = function(filenames)
    for _, filename in ipairs(filenames) do
      require("utility.source").file(filename)
    end
  end,
}

Utility.option = {
  ---
  ---Sets an `option` value. Passing 'nil' as `value` deletes the `option` (only works if there is a global fallback).
  ---
  ---[View documents](https://neovim.io/doc/user/api.html#nvim_set_option%28%29)
  ---
  ---@param option string
  ---@param value? string
  set = function(option, value)
    require("utility.option").setter(option, value)
  end,
  ---
  ---Sets multiple `option` values. Passing 'nil' as `value` deletes an `option` (only works if there is a global fallback).
  ---
  ---@param options table
  set_iter = function(options)
    for opt, val in pairs(options) do
      require("utility.option").setter(opt, val)
    end
  end,
  ---
  ---Get the option information for all changed options.
  ---
  ---This function returns a table of all changed options.
  ---
  ---@return table
  lua_changed = function()
    require("utility.option").list_changed()
  end,
}

---Enumeration for map-mode character representations
Utility.mapmode = protect({
  NORMAL = "n",
  INSERT = "i",
  COMMAND = "c",
  VISUAL = "v",
  SELECT = "s",
  OPERATOR_PENDING = "o",
  TERMINAL = "t",
})
Utility.keymap = {
  ---
  ---Sets a |mapping| for the given `mode`.
  ---
  ---[View documents](https://neovim.io/doc/user/api.html#nvim_set_keymap%28%29)
  ---
  ---@param mode string
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts any
  set = function(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, opts)
  end,
}

---
---Create or get an autocommand group |autocmd-groups|.
---
---[View documents](https://neovim.io/doc/user/api.html#nvim_create_augroup%28%29)
---
---@param o table Overrides.
---@return table
function Utility.augroup(o)
  local _meta = {
    ---
    ---Create an |autocommand|.
    ---
    ---[View documents](https://neovim.io/doc/user/api.html#nvim_create_autocmd%28%29)
    ---
    ---@param event string|table
    ---@param pattern string|table
    ---@param command string|function
    ---@param opts? table Override parameters.
    au = function(event, pattern, command, opts)
      opts = vim.tbl_extend("force", {
        group = o.augroup_id,
        pattern = pattern,
      }, opts or {})
      if type(command) == "string" then
        opts.command = command
      else
        opts.callback = command
      end
      vim.api.nvim_create_autocmd(event, opts)
      return o
    end,
  }

  if type(o) == "string" then
    local augroup_name = o
    o = { augroup_name }
  else
    o = o or {}
    o.augroup_id = vim.api.nvim_create_augroup(o[1], { clear = o.clear or true })
  end
  return setmetatable(o, { __index = _meta })
end

Utility.api = {
  ---
  ---Creates a new, empty, unnamed buffer.
  ---
  ---This function returns a new buffer handle, or the current buffer handle on error
  ---
  ---@return number
  nvim_create_buf = function()
    local bufnr = vim.api.nvim_create_buf(true, true)
    return bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
  end,
  ---
  ---Resizes the current window in an opinionated fashion.
  ---
  ---For use with utility windows; should not be in the line of focus.
  nvim_resize_win = function()
    local win_width, win_height = unpack(Utility.api.nvim_win_get_dim())
    local textwidth = vim.api.nvim_get_option_value("textwidth", {})

    textwidth = textwidth == 0 and 78 or textwidth
    if win_height < win_width and win_width > 2 * (textwidth + 5) then
      vim.cmd("vsplit") -- split right-half
    else
      vim.cmd("split | resize " .. (win_height * 1 / 3)) -- split bottom-third
    end
  end,
  ---
  ---Opens a terminal instance in a buffer.
  ---
  ---Sets focus to the given buffer handle (`bufnr`) and runs `cmd` in a non-interactive shell. If `cmd` is not given, |Terminal-mode| will be started instead in an interactive shell.
  ---
  ---@param bufnr number Empty buffer expected.
  ---@param cmd? string Shell command.
  nvim_open_term = function(bufnr, cmd)
    vim.api.nvim_win_set_buf(0, bufnr)
    vim.cmd("terminal " .. (cmd == nil and "" or cmd))
  end,
  ---
  ---This function returns a tuple for the (width, height) of the current window.
  ---
  ---@return table tuple
  nvim_win_get_dim = function()
    return {
      vim.api.nvim_win_get_width(0),
      vim.api.nvim_win_get_height(0),
    }
  end,
}

return Utility
