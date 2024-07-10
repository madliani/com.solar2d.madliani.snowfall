local _ = require "Libraries.Prelude.enumerable"

---@alias EventIdentificator string

---@class EventManager
---@field add fun(event: Event, id: EventIdentificator)
---@field pause fun(id: EventIdentificator)
---@field pauseAll fun()
---@field remove fun(id: EventIdentificator)
---@field removeAll fun()
---@field resume fun(id: EventIdentificator)
---@field resumeAll fun()

---@alias EventManagerClass fun(): EventManager
---@alias EventManagerIdentificator string

---@class EventManagerSelf: EventManagerAttributes, EventManagerMethods

---@class EventManagerAttributes
---@field events Event[] | nil

---@class EventManagerMethods
---@field add fun(self: EventManagerSelf, event: Event, id: EventIdentificator)
---@field pause fun(self: EventManagerSelf, id: EventIdentificator)
---@field pauseAll fun(self: EventManagerSelf)
---@field remove fun(self: EventManagerSelf, id: EventIdentificator)
---@field removeAll fun(self: EventManagerSelf)
---@field resume fun(self: EventManagerSelf, id: EventIdentificator)
---@field resumeAll fun(self: EventManagerSelf)

---@class EventManagerPrototype
---@field id EventManagerIdentificator
---@field attributes EventManagerAttributes
---@field methods EventManagerMethods

---@alias EventManagerSingleton fun(prototype: EventManagerPrototype): EventManagerClass

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

        pause = function(self, id)
            local event = self.events[id]

            Runtime.removeEventListener(Runtime, event.type, event.action)
        end,

        pauseAll = function(self)
            _.each(self.events, function(event)
                Runtime.removeEventListener(Runtime, event.type, event.action)
            end)
        end,

        remove = function(self, id)
            local event = self.events[id]

            Runtime.removeEventListener(Runtime, event.type, event.action)

            self.events[id] = nil
        end,

        removeAll = function(self)
            _.each(self.events, function(event)
                Runtime.removeEventListener(Runtime, event.type, event.action)
            end)

            self.events = _.map(self.events, function()
                return nil
            end)
        end,

        resume = function(self, id)
            local event = self.events[id]

            Runtime.addEventListener(Runtime, event.type, event.action)
        end,

        resumeAll = function(self)
            _.each(self.events, function(event)
                Runtime.addEventListener(Runtime, event.type, event.action)
            end)
        end,
    },
}

return EventManager
