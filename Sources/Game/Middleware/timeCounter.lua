local Loop = require "Libraries.Engine.Core.loop"
local LoopManager = require "Libraries.Engine.Middleware.loopManager"
local Snowfall = require "Sources.Game.snowfall"
local Task = require "Libraries.Engine.Core.task"
local string = require "string"

---@class TimeCounter
---@field pause fun()
---@field reset fun()
---@field start fun()
---@field stop fun()

---@alias TimeCounterClass fun(time: Time, miliseconds: Miliseconds): TimeCounter

---@alias TimeCounterIdentificator string

---@class TimeCounterAttributes
---@field counter Miliseconds | nil
---@field time Time | nil

---@class TimeCounterSelf: TimeCounterAttributes, TimeCounterMethods

---@class TimeCounterMethods
---@field pause fun(self: TimeCounterSelf)
---@field reset fun(self: TimeCounterSelf)
---@field start fun(self: TimeCounterSelf)
---@field stop fun(self: TimeCounterSelf)

---@alias TimeCounterInitializer fun(attributes: TimeCounterAttributes, time: Time, miliseconds: Miliseconds)
---@alias TimeCounterFinalizer fun(attributes: TimeCounterAttributes)

---@class TimeCounterPrototype
---@field id TimeCounterIdentificator
---@field attributes TimeCounterAttributes
---@field methods TimeCounterMethods
---@field initializer TimeCounterInitializer?
---@field finalizer TimeCounterFinalizer?

---@alias TimeCounterMetaclass fun(prototype: TimeCounterPrototype): TimeCounterClass

---@type TimeCounterMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local TimeCounter = Metaclass {
    id = "time_counter",

    attributes = {
        counter = nil,
        time = nil,
    },

    methods = {
        pause = function(_)
            local loopManager = LoopManager()

            loopManager.pause "time_counter"
        end,

        reset = function(self)
            local loopManager = LoopManager()

            loopManager.remove "task_counter"

            loopManager.add(
                Loop {
                    task = Task {
                        action = function()
                            self.counter = self.counter - 1

                            if self.counter > 0 then
                                local minutes = math.floor(self.counter / 60)
                                local seconds = self.counter % 60
                                local time = string.format("%i:%i", minutes, seconds)

                                self.time.updateText(time)
                            else
                                Snowfall.exit()
                            end
                        end,
                        time = 1000,
                    },
                },
                "time_counter"
            )
        end,

        start = function(self)
            local loopManager = LoopManager()

            loopManager.add(
                Loop {
                    task = Task {
                        action = function()
                            self.counter = self.counter - 1

                            if self.counter > 0 then
                                local minutes = math.floor(self.counter / 60)
                                local seconds = self.counter % 60
                                local time = string.format("%i:%i", minutes, seconds)

                                self.time.updateText(time)
                            else
                                Snowfall.exit()
                            end
                        end,
                        time = 1000,
                    },
                },
                "time_counter"
            )
        end,

        stop = function(_)
            local loopManager = LoopManager()

            loopManager.remove "time_counter"
        end,
    },

    initializer = function(attributes, time, miliseconds)
        attributes.counter = miliseconds / 100
        attributes.time = time
    end,
}

return TimeCounter
