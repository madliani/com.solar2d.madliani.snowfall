---@class Event
---@field action function
---@field type string

---@alias EventClass fun(action: function, type: string): Event
---@alias EventIdentificator string

---@class EventPrototype
---@field id EventIdentificator
---@field maker fun(action: function, type: string): Event

---@alias EventContainer fun(prototype: EventPrototype): EventClass

---@type EventContainer
local Container = require "Libraries.Prelude.container"

local Event = Container {
    id = "event",

    maker = function(action, type)
        return {
            action = action,
            type = type,
        }
    end,
}

return Event
