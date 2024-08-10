---@class Coordinate
---@field x integer
---@field y integer

---@alias CoordinateClass fun(x: integer, y: integer): Coordinate
---@alias CoordinateIdentificator string

---@class CoordinatePrototype
---@field id CoordinateIdentificator
---@field maker fun(x: integer, y: integer): Coordinate

---@alias CoordinateContainer fun(prototype: CoordinatePrototype): CoordinateClass

---@type CoordinateContainer
local Container = require "Libraries.Prelude.container"

local Coordinate = Container {
    id = "coordinate",

    maker = function(x, y)
        return {
            x = x,
            y = y,
        }
    end,
}

return Coordinate
