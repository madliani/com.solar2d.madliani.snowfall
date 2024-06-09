---@alias EventIdentificator string

---@class EventManager
---@field add fun(event: Event, id: EventIdentificator)
---@field remove fun(id: EventIdentificator)
---@field pause fun(id: EventIdentificator)
---@field resume fun(id: EventIdentificator)

---@alias EventManagerClass fun(): EventManager
---@alias EventManagerIdentificator string

---@class EventManagerAttributes
---@field events Event[] | nil

---@class EventManagerSelf: EventManagerMethods
---@field events Event[]

---@class EventManagerMethods
---@field add fun(self: EventManagerSelf, event: Event, id: EventIdentificator)
---@field remove fun(self: EventManagerSelf, id: EventIdentificator)
---@field pause fun(self: EventManagerSelf, id: EventIdentificator)
---@field resume fun(self: EventManagerSelf, id: EventIdentificator)

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
            local event = self.events[id]

            Runtime.removeEventListener(Runtime, event.type, event.action)

            self.events[id] = nil
        end,

        pause = function(self, id)
            local event = self.events[id]

            Runtime.removeEventListener(Runtime, event.type, event.action)
        end,

        resume = function(self, id)
            local event = self.events[id]

            Runtime.addEventListener(Runtime, event.type, event.action)
        end,
    },
}

return EventManager
