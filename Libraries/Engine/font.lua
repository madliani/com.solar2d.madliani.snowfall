local native = require "native"

---@param path string
local Font = function(path)
    ---@class Font
    return native.newFont(path)
end

return Font
