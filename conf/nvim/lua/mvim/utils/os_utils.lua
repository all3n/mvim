local M = {}



function M.get_env(name, default)
  local value = os.getenv(name)
  if value == nil then
    value = default
  end
  return value
end


return M
