---@class Size
---@field width integer
---@field height integer

---@alias SizeClass fun(size: Size): Size
---@alias SizeIdentificator string

---@class SizePrototype
---@field id SizeIdentificator
---@field maker fun(size: Size): Size

---@alias SizeContainer fun(prototype: SizePrototype): SizeClass

---@type SizeContainer
local Container = require "Libraries.Prelude.container"

local Size = Container {
    id = "size",

    maker = function(size)
        return size
    end,
}

return Size
