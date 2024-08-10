---@class Color
---@field red integer
---@field green integer
---@field blue integer

---@alias ColorClass fun(red: integer, green: integer, blue: integer): Color
---@alias ColorIdentificator string

---@class ColorPrototype
---@field id ColorIdentificator
---@field maker fun(red: integer, green: integer, blue: integer): Color

---@alias ColorContainer fun(prototype: ColorPrototype): ColorClass

---@type ColorContainer
local Container = require "Libraries.Prelude.container"

local Color = Container {
    id = "color",

    maker = function(red, green, blue)
        return {
            red = red,
            green = green,
            blue = blue,
        }
    end,
}

return Color
