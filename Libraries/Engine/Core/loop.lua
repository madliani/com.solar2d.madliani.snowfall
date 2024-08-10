---@class Loop
---@field task Task
---@field event Event

---@alias LoopClass fun(task: Task, event: Event): Loop
---@alias LoopIdentificator string

---@class LoopPrototype
---@field id LoopIdentificator
---@field maker fun(task: Task, event: Event): Loop

---@alias LoopContainer fun(prototype: LoopPrototype): LoopClass

---@type LoopContainer
local Container = require "Libraries.Prelude.container"

local Loop = Container {
    id = "loop",

    maker = function(task, event)
        return {
            task = task,
            event = event,
        }
    end,
}

return Loop
