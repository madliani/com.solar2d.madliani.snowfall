---@class Title
---@field text string
---@field font Font
---@field color Color
---@field size integer

local Title = function(text, font, color, size)
    return {
        text = text,
        font = font,
        color = color,
        size = size,
    }
end

return Title
