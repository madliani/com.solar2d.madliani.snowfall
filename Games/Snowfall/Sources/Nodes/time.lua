local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Label = require "Libraries.Engine.Nodes.label"
local Resources = require "resources"
local Title = require "Libraries.Engine.Core.title"
local display = require "display"

---@class Time: Label
---@field updateText fun(newText: string)

---@alias TimeClass fun(time: integer): Time
---@alias TimeIdentificator string

---@class TimeAttributes
---@field label Label | nil
---@field time string | nil

---@class TimeSelf: TimeAttributes, TimeMethods

---@class TimeMethods
---@field create fun(self: TimeSelf, group: table)
---@field destroy fun(self: TimeSelf)
---@field hide fun(self: TimeSelf)
---@field show fun(self: TimeSelf)
---@field updateText fun(self: TimeSelf, newText: string)

---@alias TimeInitializer fun(attributes: TimeAttributes, time: integer)
---@alias TimeFinalizer fun(attributes: TimeAttributes)

---@class TimePrototype
---@field id TimeIdentificator
---@field attributes TimeAttributes
---@field methods TimeMethods
---@field initializer TimeInitializer?
---@field finalizer TimeFinalizer?

---@alias TimeMetaclass fun(prototype: TimePrototype): TimeClass

---@type TimeMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Time = Metaclass {
    id = "time",

    attributes = {
        label = nil,
        time = nil,
    },

    methods = {
        create = function(self, group)
            self.label.create(group)
        end,

        destroy = function(self)
            self.label.destroy()
        end,

        hide = function(self)
            self.label.hide()
        end,

        show = function(self)
            self.label.show()
        end,

        updateText = function(self, newText)
            self.label.updateText(newText)
        end,
    },

    initializer = function(attributes, initialTime)
        local minutes = math.floor(initialTime / 100 / 60)
        local seconds = initialTime / 100 % 60
        local time = string.format("%i:%i", minutes, seconds)

        local color = Color {
            red = 0,
            green = 0,
            blue = 0,
        }

        local font = Font(Resources.Fonts.architectsDaughter)
        local title = Title {
            text = tostring(time),
            font = font,
            color = color,
            size = 48,
        }

        local coordinate = Coordinate {
            x = display.contentCenterX + display.pixelWidth / 5,
            y = 0,
        }

        attributes.label = Label {
            title = title,
            coordinate = coordinate,
        }

        attributes.time = time
    end,

    finalizer = function(attributes)
        attributes.label = nil
    end,
}

return Time
