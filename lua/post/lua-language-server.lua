--[[
-- File name:      lua/post/lua-language-server.lua
-- Last modified:  (2021-Aug-02)
-- Description:    a setup script after successful installation of the
--   lua-language-server plugin.
]]

local Config = {}
local shell = vim.env.SHELL -- tested with /bin/bash

function Config:create(o)
  o = o or {}
  setmetatable(o, self)

  --[[ run()
  -- returns: a string of shell commands joined together to be run sequentially.
  --   The chain is run in a subshell - `$SHELL -c <cmd>`
  -- see :h packer-plugin-hooks
  ]]
  o.run = function()
    local shell_cmds = {
      "git submodule update --init --recursive",
      "cd 3rd/luamake/",
      "echo -n 'Compiling... '",
      "compile/install.sh 1>/dev/null 2>&1",
      "echo DONE",
      "cd ../..",
      "echo -n 'Building... '",
      "./3rd/luamake/luamake rebuild 1>/dev/null 2>&1",
      "echo DONE",
      "./3rd/luamake/luamake clean 2>&1",
    }
    return table.concat(shell_cmds, ";")
  end

  return o
end

return Config:create()
