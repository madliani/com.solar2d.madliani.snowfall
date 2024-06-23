local EventManager = require "Libraries.Engine.Core.eventManager"
local TaskManager = require "Libraries.Engine.Core.taskManager"
local _ = require "Libraries.Prelude.enumerable"

---@alias LoopIdentificator string

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

---@class LoopManagerMetaclass
---@field id LoopManagerIdentificator
---@field attributes LoopManagerAttributes
---@field methods LoopManagerMethods

---@alias LoopManagerSingleton fun(metaclass: LoopManagerMetaclass): LoopManagerClass

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

            taskManager.addInfinite(loop.task, id)

            eventManager.add(loop.event, id)
        end,

        pause = function(self, id)
            local loop = self.loops[id]

            taskManager.pause(id)

            eventManager.pause(id)
        end,

        pauseAll = function()
            taskManager.pauseAll()
            eventManager.pauseAll()
        end,

        remove = function(self, id)
            local loop = self.loops[id]

            taskManager.remove(id)

            eventManager.remove(id)

            self.loops[id] = nil
        end,

        removeAll = function(self)
            taskManager.removeAll()
            eventManager.removeAll()

            self.loops = _.map(self.loops, function()
                return nil
            end)

            self.loops = nil
        end,

        resume = function(self, id)
            local loop = self.loops[id]

            taskManager.resume(id)

            eventManager.resume(id)
        end,

        resumeAll = function()
            taskManager.resumeAll()
            eventManager.resumeAll()
        end,
    },
}

return LoopManager
