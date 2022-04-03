local _require = require("utility.try_require")

return function(config, dependencies)
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
