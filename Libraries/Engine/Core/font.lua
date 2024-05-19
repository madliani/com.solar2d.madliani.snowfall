local native = require "native"

---@param filename string
local Font = function(filename)
    if filename == "system" then
        return native.systemFont
    end

    ---@class Font
    return native.newFont(filename)
end

return Font
