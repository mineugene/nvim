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
  ---[[ BEGIN: extension to require() input signature
  if type(o) == "table" or not o then
    -- multiple modules to require()
    o = o or {}
  else
    -- typical require() input signature
    local sngl_modname = o
    o = { sngl_modname }
  end
  --[=[]] -- continue without type check
  o = o or {}
  -- END: extension to require() input signature ]=]

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
        require("utility.try_configure")(mods[i], i == 1 and o.dependencies or {})
        i = i + 1
      until i > #mods
    end,
  }
  return setmetatable(o, {
    __index = _meta,
  })
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
  lua_changed = require("utility.option").list_changed(),
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
  ---@param mode string
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts any
  set = function(mode, lhs, rhs, opts)
    local bufnr = opts.buffer == true and 0 or opts.buffer
    opts = vim.deepcopy(opts)
    opts.buffer = nil

    require("utility.keymap").setter(bufnr, mode, lhs, rhs, opts)
  end,
}

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
    local textwidth = vim.api.nvim_get_option("textwidth")

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
