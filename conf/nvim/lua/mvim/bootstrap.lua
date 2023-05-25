local M = {}
function _G.join_paths(...)
    local result = table.concat({ ... }, path_sep)
    return result
end

function M:init()
    require("mvim.config")
end

return M
