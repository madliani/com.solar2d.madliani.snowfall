---@class Event
---@field action function
---@field type string

---@alias EventClass fun(event: Event): Event
---@alias EventIdentificator string

---@class EventPrototype
---@field id EventIdentificator
---@field maker fun(event: Event): Event

---@alias EventContainer fun(prototype: EventPrototype): EventClass

---@type EventContainer
local Container = require "Libraries.Prelude.container"

local Event = Container {
    id = "event",

    maker = function(event)
        return event
    end,
}

return Event
