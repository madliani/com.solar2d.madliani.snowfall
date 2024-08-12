local Coordinate = require "Libraries.Engine.Core.coordinate"
local Event = require "Libraries.Engine.Core.event"
local Image = require "Libraries.Engine.Nodes.image"
local Resources = require "resources"
local Size = require "Libraries.Engine.Core.size"
local Snowfall = require "Sources.snowfall"
local display = require "display"
local paths = require "Sources.paths"

---@class Pause: Image

---@alias PauseClass fun(): Pause
---@alias PauseIdentificator string

---@class PauseAttributes
---@field image Image | nil

---@class PauseSelf: PauseAttributes, PauseMethods

---@class PauseMethods
---@field create fun(self: PauseSelf, group: table)
---@field destroy fun(self: PauseSelf)
---@field show fun(self: PauseSelf)
---@field hide fun(self: PauseSelf)

---@alias PauseInitializer fun(attributes: PauseAttributes)
---@alias PauseFinalizer fun(attributes: PauseAttributes)

---@class PausePrototype
---@field id PauseIdentificator
---@field attributes PauseAttributes
---@field methods PauseMethods
---@field initializer PauseInitializer?
---@field finalizer PauseFinalizer?

---@alias PauseMetaclass fun(prototype: PausePrototype): PauseClass

---@type PauseMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Pause = Metaclass {
    id = "pause",

    attributes = {
        image = nil,
    },

    methods = {
        create = function(self, group)
            self.image.create(group)
        end,

        destroy = function(self)
            self.image.destroy()
        end,

        show = function(self)
            self.image.show()
        end,

        hide = function(self)
            self.image.hide()
        end,
    },

    initializer = function(attributes)
        local coordinate = Coordinate {
            x = 50, y = display.contentHeight + 25
        }

        local size = Size {
            width = 25,
            height = 25
        }

        local path = Resources.Images.transparrentPause

        local event = Event {
            action = function()
                Snowfall.pause(paths.Scenes.pauseMenu)
            end,
            type = "tap"
        }

        attributes.image = Image(path, size, coordinate, event)
    end,

    finalizer = function(attributes)
        attributes.image = nil
    end,
}

return Pause
