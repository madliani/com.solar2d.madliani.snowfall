---@class Coordinate
---@field x integer
---@field y integer

---@alias CoordinateClass fun(coordinate: Coordinate): Coordinate
---@alias CoordinateIdentificator string

---@class CoordinatePrototype
---@field id CoordinateIdentificator
---@field maker fun(coordinate: Coordinate): Coordinate

---@alias CoordinateContainer fun(prototype: CoordinatePrototype): CoordinateClass

---@type CoordinateContainer
local Container = require "Libraries.Prelude.container"

local Coordinate = Container {
    id = "coordinate",

    maker = function(coordinate)
        return coordinate
    end,
}

return Coordinate
