local _require = function(modname)
  if package.loaded[modname] then
    return true
  end

  for _, searcher in ipairs(package.searchers or package.loaders) do
    local loader = searcher(modname)
    if type(loader or {}) == "function" then
      package.preload[modname] = loader
      return true
    end
  end
  return false
end

local _configure = function(config, dependencies)
  -- validate dependencies
  for _, dep in ipairs(dependencies) do
    if not _require(dep) then
      return true
    end
  end

  -- return callback to configuration module
  if _require(config) then
    require(config)
  end
end

return {
  require = _require,
  configure = _configure,
}
