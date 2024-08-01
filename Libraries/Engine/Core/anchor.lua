---@param x integer
---@param y integer
local Anchor = function(x, y)
    ---@class Anchor
    ---@field x integer
    ---@field y integer
    return {
        x = x,
        y = y,
    }
end

return Anchor
