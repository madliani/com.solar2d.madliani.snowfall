---@class Loop
---@field task Task
---@field event Event?

---@alias LoopClass fun(loop: Loop): Loop
---@alias LoopIdentificator string

---@class LoopPrototype
---@field id LoopIdentificator
---@field maker fun(loop: Loop): Loop

---@alias LoopContainer fun(prototype: LoopPrototype): LoopClass

---@type LoopContainer
local Container = require "Libraries.Prelude.container"

local Loop = Container {
    id = "loop",

    maker = function(loop)
        return loop
    end,
}

return Loop
