return function(o)
  return setmetatable({}, {
    __index = o,
    __newindex = function(_, key, val)
      error(tostring(key) .. " is read-only: can't assign to " .. tostring(val) .. ".", 2)
    end,
  })
end
