---@param text string
---@param font Font
---@param color Color
---@param size integer
local Title = function(text, font, color, size)
    ---@class Title
    ---@field text string
    ---@field font Font
    ---@field color Color
    ---@field size integer
    return {
        text = text,
        font = font,
        color = color,
        size = size,
    }
end

return Title
