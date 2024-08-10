---@class Anchor
---@field x integer
---@field y integer

---@alias AnchorClass fun(x: integer, y: integer): Anchor
---@alias AnchorIdentificator string

---@class AnchorPrototype
---@field id AnchorIdentificator
---@field maker fun(x: integer, y: integer): Anchor

---@alias AnchorContainer fun(prototype: AnchorPrototype): AnchorClass

---@type AnchorContainer
local Contianer = require "Libraries.Prelude.container"

local Anchor = Contianer {
    id = "anchor",

    maker = function(x, y)
        return {
            x = x,
            y = y,
        }
    end,
}

return Anchor
