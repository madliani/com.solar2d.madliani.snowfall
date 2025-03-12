local Event = require "Libraries.Engine.Core.event"
local Loop = require "Libraries.Engine.Core.loop"
local LoopManager = require "Libraries.Engine.Middleware.loopManager"
local Resources = require "Sources.resources"
local Snowflake = require "Sources.Nodes.snowflake"
local Task = require "Libraries.Engine.Core.task"

---@class Blizzard
---@field create fun(group: table)
---@field destroy fun()
---@field show fun()
---@field hide fun()

---@alias BlizzardClass fun(scoreCounter: ScoreCounter): Blizzard
---@alias BlizzardIdentificator string

---@class BlizzardAttributes
---@field sceneGroup table | nil
---@field scoreCounter ScoreCounter | nil
---@field snowflakes Snowflake[] | nil

---@class BlizzardSelf: BlizzardAttributes, BlizzardMethods

---@class BlizzardMethods
---@field create fun(self: BlizzardSelf, group: table)
---@field destroy fun(self: BlizzardSelf)
---@field show fun(self: BlizzardSelf)
---@field hide fun(self: BlizzardSelf)

---@alias BlizzardInitializer fun(attributes: BlizzardAttributes, scoreCounter: ScoreCounter)
---@alias BlizzardFinalizer fun(attributes: BlizzardAttributes)

---@class BlizzardPrototype
---@field id BlizzardIdentificator
---@field attributes BlizzardAttributes
---@field methods BlizzardMethods
---@field initializer BlizzardInitializer?
---@field finalizer BlizzardFinalizer?

---@alias BlizzardMetaclass fun(prototype: BlizzardPrototype): BlizzardClass

---@type BlizzardMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Blizzard = Metaclass {
    id = "blizzard",

    attributes = {
        sceneGroup = nil,
        scoreCounter = nil,
        snowflakes = nil,
    },

    methods = {
        create = function(self, group)
            self.sceneGroup = group

            local function generate()
                if self.sceneGroup ~= nil then
                    local snowflake = Snowflake(Resources.Images.snowflake, self.scoreCounter)

                    snowflake.create(self.sceneGroup)
                    table.insert(self.snowflakes, snowflake)
                end
            end

            local function update()
                if #self.snowflakes > 0 then
                    for i = #self.snowflakes, 1, -1 do
                        local snowflake = self.snowflakes[i]

                        if snowflake.isUnavailable() then
                            snowflake.destroy()
                            table.remove(snowflake, i)
                        else
                            snowflake.update()
                        end
                    end
                end
            end

            local task = Task {
                action = generate,
                time = 500,
            }

            local event = Event {
                action = update,
                type = "enterFrame",
            }

            local loop = Loop {
                task = task,
                event = event,
            }

            local loopManager = LoopManager()

            loopManager.add(loop, "blizzard")
        end,

        destroy = function(self)
            if #self.snowflakes > 0 and self.sceneGroup ~= nil then
                for i = 1, #self.snowflakes, 1 do
                    local snowflake = self.snowflakes[i]

                    snowflake.destroy()
                end

                self.sceneGroup = nil
            end
        end,

        show = function(self)
            if #self.snowflakes > 0 then
                for i = 1, #self.snowflakes, 1 do
                    local snowflake = self.snowflakes[i]

                    snowflake.show()
                end
            end
        end,

        hide = function(self)
            if #self.snowflakes > 0 then
                for i = 1, #self.snowflakes, 1 do
                    local snowflake = self.snowflakes[i]

                    snowflake.hide()
                end
            end
        end,
    },

    initializer = function(attributes, scoreCounter)
        attributes.scoreCounter = scoreCounter
        attributes.snowflakes = {}
    end,
}

return Blizzard
