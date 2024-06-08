---@alias EventIdentificator string

---@class EventManager
---@field add fun(event: Event, id: EventIdentificator)
---@field remove fun(id: EventIdentificator)

---@alias EventManagerClass fun(): EventManager
---@alias EventManagerIdentificator string

---@class EventManagerAttributes
---@field events table<Event> | nil

---@class EventManagerSelf
---@field events table<Event> | nil
---@field add fun(self: EventManagerSelf, event: Event, id: EventIdentificator)
---@field remove fun(self: EventManagerSelf, id: EventIdentificator)

---@class EventManagerMethods
---@field add fun(self: EventManagerSelf, event: Event, id: EventIdentificator)
---@field remove fun(self: EventManagerSelf, id: EventIdentificator)

---@class EventManagerMetaclass
---@field id EventManagerIdentificator
---@field attributes EventManagerAttributes
---@field methods EventManagerMethods

---@alias EventManagerSingleton fun(metaclass: EventManagerMetaclass): EventManagerClass

---@type EventManagerSingleton
local Singleton = require "Libraries.Prelude.singleton"

local EventManager = Singleton {
    id = "event_manager",

    attributes = {
        events = {},
    },

    methods = {
        add = function(self, event, id)
            self.events[id] = event

            Runtime.addEventListener(Runtime, event.type, event.action)
        end,

        remove = function(self, id)
            local type = self.events[id].type
            local action = self.events[id].action

            Runtime.removeEventListener(Runtime, type, action)

            self.events[id] = nil
        end,
    },
}

return EventManager
