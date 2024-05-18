---@param color Color
---@param font string
---@param size integer
---@param text string
local Title = function(color, text, font, size)
    ---@class Title
    ---@field color Color
    ---@field text string
    ---@field font string
    ---@field size integer
    return {
        color = color,
        text = text,
        font = font,
        size = size,
    }
end

return Title
