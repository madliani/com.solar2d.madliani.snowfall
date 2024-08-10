---@class Scale
---@field x integer
---@field y integer

---@alias ScaleClass fun(x: integer, y: integer): Scale
---@alias ScaleIdentificator string

---@class ScalePrototype
---@field id ScaleIdentificator
---@field maker fun(x: integer, y: integer): Scale

---@alias ScaleContainer fun(prototype: ScalePrototype): ScaleClass

---@type ScaleContainer
local Container = require "Libraries.Prelude.container"

local Scale = Container {
    id = "scale",

    maker = function(x, y)
        return {
            x = x,
            y = y,
        }
    end,
}

return Scale
