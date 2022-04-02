local fn = vim.fn

return function(uri, path, runtime)
  if fn.empty(fn.glob(path)) == 0 then
    return -- directory exists
  end
  if fn.system({ "git", "clone", "--depth", "1", uri, path }) then
    vim.o.runtimepath = runtime .. "," .. vim.o.runtimepath
  end
end
