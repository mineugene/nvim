return function(modname)
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
