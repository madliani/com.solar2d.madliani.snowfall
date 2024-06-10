local EventManager = require "Libraries.Engine.Core.eventManager"
local TaskManager = require "Libraries.Engine.Core.taskManager"

---@alias LoopIdentificator string

---@class LoopManager
---@field add fun(loop: Loop, id: LoopIdentificator)
---@field remove fun(id: LoopIdentificator)
---@field pause fun(id: LoopIdentificator)
---@field resume fun(id: LoopIdentificator)

---@alias LoopManagerClass fun(): LoopManager
---@alias LoopManagerIdentificator string

---@class LoopManagerAttributes
---@field loops Loop[] | nil

---@class LoopManagerSelf: LoopManagerMethods
---@field loops Loop[]

---@class LoopManagerMethods
---@field add fun(self: LoopManagerSelf, loop: Loop, id: LoopIdentificator)
---@field remove fun(self: LoopManagerSelf, id: LoopIdentificator)
---@field pause fun(self: LoopManagerSelf, id: LoopIdentificator)
---@field resume fun(self: LoopManagerSelf, id: LoopIdentificator)

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

            if loop.event ~= nil then
                eventManager.add(loop.event, id)
            end
        end,

        remove = function(self, id)
            local loop = self.loops[id]

            taskManager.remove(id)

            if loop.event ~= nil then
                eventManager.remove(id)
            end

            self.loops[id] = nil
        end,

        pause = function(self, id)
            local loop = self.loops[id]

            taskManager.pause(id)

            if loop.event ~= nil then
                eventManager.pause(id)
            end
        end,

        resume = function(self, id)
            local loop = self.loops[id]

            taskManager.resume(id)

            if loop.event ~= nil then
                eventManager.resume(id)
            end
        end,
    },
}

return LoopManager
