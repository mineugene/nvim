local _nameof = function(o)
  for name, val in pairs(_G) do
    if val == o then
      return name
    end
  end
  return "?"
end

local _extend = function(base, key, val)
  if base[key] == nil then
    base[key] = val
    return val
  elseif base[key] ~= val then
    local error_msg_extend = string.format(
      "%s.%s already exists: can't assign to %s.",
      _nameof(base),
      key,
      tostring(val)
    )
    error(error_msg_extend)
  end
end

return {
  extend = _extend,
}
