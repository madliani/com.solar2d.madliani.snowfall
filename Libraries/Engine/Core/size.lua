---@class Size
---@field width integer
---@field height integer

---@alias SizeClass fun(width: integer, height: integer): Size
---@alias SizeIdentificator string

---@class SizePrototype
---@field id SizeIdentificator
---@field maker fun(width: integer, height: integer): Size

---@alias SizeContainer fun(prototype: SizePrototype): SizeClass

---@type SizeContainer
local Container = require "Libraries.Prelude.container"

local Size = Container {
    id = "size",

    maker = function(width, height)
        return {
            width = width,
            height = height,
        }
    end,
}

return Size
