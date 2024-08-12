---@class Scale
---@field x integer
---@field y integer

---@alias ScaleClass fun(scale: Scale): Scale
---@alias ScaleIdentificator string

---@class ScalePrototype
---@field id ScaleIdentificator
---@field maker fun(scale: Scale): Scale

---@alias ScaleContainer fun(prototype: ScalePrototype): ScaleClass

---@type ScaleContainer
local Container = require "Libraries.Prelude.container"

local Scale = Container {
    id = "scale",

    maker = function(scale)
        return scale
    end,
}

return Scale
