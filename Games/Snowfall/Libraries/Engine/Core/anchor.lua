---@class Anchor
---@field x integer
---@field y integer

---@alias AnchorClass fun(anchor: Anchor): Anchor
---@alias AnchorIdentificator string

---@class AnchorPrototype
---@field id AnchorIdentificator
---@field maker fun(anchor: Anchor): Anchor

---@alias AnchorContainer fun(prototype: AnchorPrototype): AnchorClass

---@type AnchorContainer
local Contianer = require "Libraries.Prelude.container"

local Anchor = Contianer {
    id = "anchor",

    maker = function(anchor)
        return anchor
    end,
}

return Anchor
