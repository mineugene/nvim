local protect = require("utility.extensions.protect")
local Utility = {
  packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim",
  packer_runtime = vim.fn.stdpath("data") .. "/site/pack/*/start/*",
}

function Utility.bootstrap(self, o)
  self.__index = self

  o = o or {}
  o.packer = function()
    require("utility.bootstrap")(o[1] or o.packer_uri, o.packer_path, o.packer_runtime)
  end

  return setmetatable(o, self)
end

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
    depends_on = function(dependencies)
      o.dependencies = dependencies
      return o
    end,
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
  file = require("utility.source").file,
  file_iter = function(filenames)
    for _, filename in ipairs(filenames) do
      require("utility.source").file(filename)
    end
  end,
}

Utility.option = {
  set = require("utility.option").setter,
  set_iter = function(options)
    for opt, val in pairs(options) do
      require("utility.option").setter(opt, val)
    end
  end,
  lua_changed = require("utility.option").list_changed(),
}

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
  set = function(mode, lhs, rhs, opts)
    local bufnr = opts.buffer == true and 0 or opts.buffer
    opts = vim.deepcopy(opts)
    opts.buffer = nil

    require("utility.keymap").setter(bufnr, mode, lhs, rhs, opts)
  end,
}

Utility.api = {
  nvim_create_buf = function()
    local bufnr = vim.api.nvim_create_buf(true, true)
    return bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
  end,
  nvim_win_get_dim = function()
    return {
      vim.api.nvim_win_get_width(0),
      vim.api.nvim_win_get_height(0),
    }
  end,
}

return Utility
