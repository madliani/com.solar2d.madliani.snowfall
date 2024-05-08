---@param family string
---@param size integer
local Font = function(family, size)
    ---@class Font
    ---@field family string
    ---@field size integer
    return {
        family = family,
        size = size,
    }
end

return Font
