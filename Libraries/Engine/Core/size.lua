---@param width integer
---@param height integer
local Size = function(width, height)
    ---@class Size
    ---@field width integer
    ---@field height integer
    return {
        width = width,
        height = height,
    }
end

return Size
