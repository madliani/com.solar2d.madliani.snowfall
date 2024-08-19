local EventManager = require "Libraries.Engine.Middleware.eventManager"
local TaskManager = require "Libraries.Engine.Middleware.taskManager"
local _ = require "Libraries.Prelude.enumerable"

---@class LoopManager
---@field add fun(loop: Loop, id: LoopIdentificator)
---@field pause fun(id: LoopIdentificator)
---@field pauseAll fun()
---@field remove fun(id: LoopIdentificator)
---@field removeAll fun()
---@field resume fun(id: LoopIdentificator)
---@field resumeAll fun()

---@alias LoopManagerClass fun(): LoopManager
---@alias LoopManagerIdentificator string

---@class LoopManagerSelf: LoopManagerAttributes, LoopManagerMethods

---@class LoopManagerAttributes
---@field loops Loop[] | nil

---@class LoopManagerMethods
---@field add fun(self: LoopManagerSelf, loop: Loop, id: LoopIdentificator)
---@field pause fun(self: LoopManagerSelf, id: LoopIdentificator)
---@field pauseAll fun()
---@field remove fun(self: LoopManagerSelf, id: LoopIdentificator)
---@field removeAll fun(self: LoopManagerSelf)
---@field resume fun(self: LoopManagerSelf, id: LoopIdentificator)
---@field resumeAll fun()

---@class LoopManagerPrototype
---@field id LoopManagerIdentificator
---@field attributes LoopManagerAttributes
---@field methods LoopManagerMethods

---@alias LoopManagerSingleton fun(prototype: LoopManagerPrototype): LoopManagerClass

---@type LoopManagerSingleton
local Singleton = require "Libraries.Prelude.singleton"

local taskManager = TaskManager()
local eventManager = EventManager()

local LoopManager = Singleton {
    id = "loop_manger",

    attributes = {
        loops = {},
    },

    methods = {
        add = function(self, loop, id)
            self.loops[id] = loop

            if loop.task ~= nil then
                taskManager.addInfinite(loop.task, id)
            end

            if loop.event ~= nil then
                eventManager.add(loop.event, id)
            end
        end,

        pause = function(self, id)
            if self.loops[id] ~= nil and self.loops[id].task ~= nil then
                taskManager.pause(id)
            end

            if self.loops[id] ~= nil and self.loops[id].event ~= nil then
                eventManager.pause(id)
            end
        end,

        pauseAll = function()
            taskManager.pauseAll()
            eventManager.pauseAll()
        end,

        remove = function(self, id)
            if self.loops[id] ~= nil and self.loops[id].task ~= nil then
                taskManager.remove(id)
            end

            if self.loops[id] ~= nil and self.loops[id].event ~= nil then
                eventManager.remove(id)
            end

            self.loops[id] = nil
        end,

        removeAll = function(self)
            taskManager.removeAll()
            eventManager.removeAll()

            self.loops = _.map(self.loops, function()
                return nil
            end)
        end,

        resume = function(self, id)
            if self.loops[id] ~= nil and self.loops[id].task ~= nil then
                taskManager.resume(id)
            end

            if self.loops[id] ~= nil and self.loops[id].event ~= nil then
                eventManager.resume(id)
            end
        end,

        resumeAll = function()
            taskManager.resumeAll()
            eventManager.resumeAll()
        end,
    },
}

return LoopManager
