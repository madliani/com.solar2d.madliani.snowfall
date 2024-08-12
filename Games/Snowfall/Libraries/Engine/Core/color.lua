---@class Color
---@field red integer
---@field green integer
---@field blue integer

---@alias ColorClass fun(color: Color): Color
---@alias ColorIdentificator string

---@class ColorPrototype
---@field id ColorIdentificator
---@field maker fun(color: Color): Color

---@alias ColorContainer fun(prototype: ColorPrototype): ColorClass

---@type ColorContainer
local Container = require "Libraries.Prelude.container"

local Color = Container {
    id = "color",

    maker = function(color)
        return color
    end,
}

return Color
