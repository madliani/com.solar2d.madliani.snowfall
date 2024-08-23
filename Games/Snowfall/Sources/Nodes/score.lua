local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Label = require "Libraries.Engine.Nodes.label"
local Resources = require "resources"
local Title = require "Libraries.Engine.Core.title"
local display = require "display"

---@class Score: Label
---@field dec fun()
---@field inc fun()

---@alias ScoreClass fun(score: integer): Score
---@alias ScoreIdentificator string

---@class ScoreAttributes
---@field label Label | nil
---@field score integer | nil

---@class ScoreSelf: ScoreAttributes, ScoreMethods

---@class ScoreMethods
---@field create fun(self: ScoreSelf, group: table)
---@field dec fun(self: ScoreSelf)
---@field destroy fun(self: ScoreSelf)
---@field hide fun(self: ScoreSelf)
---@field inc fun(self: ScoreSelf)
---@field show fun(self: ScoreSelf)
---@field updateText fun(self: ScoreSelf, newText: string)

---@alias ScoreInitializer fun(attributes: ScoreAttributes, score: integer)
---@alias ScoreFinalizer fun(attributes: ScoreAttributes)

---@class ScorePrototype
---@field id ScoreIdentificator
---@field attributes ScoreAttributes
---@field methods ScoreMethods
---@field initializer ScoreInitializer?
---@field finalizer ScoreFinalizer?

---@alias ScoreMetaclass fun(prototype: ScorePrototype): ScoreClass

---@type ScoreMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Score = Metaclass {
    id = "score",

    attributes = {
        label = nil,
        score = nil,
    },

    methods = {
        create = function(self, group)
            self.label.create(group)
        end,

        dec = function(self)
            self.score = self.score - 1

            self.label.updateText(tostring(self.score))
        end,

        destroy = function(self)
            self.label.destroy()
        end,

        hide = function(self)
            self.label.hide()
        end,

        inc = function(self)
            self.score = self.score + 1

            self.label.updateText(tostring(self.score))
        end,

        show = function(self)
            self.label.show()
        end,

        updateText = function(self, newText)
            self.label.updateText(newText)
        end,
    },

    initializer = function(attributes, initialCount)
        local color = Color {
            red = 0,
            green = 0,
            blue = 0,
        }

        local font = Font(Resources.Fonts.main)
        local title = Title {
            text = tostring(initialCount),
            font = font,
            color = color,
            size = 48,
        }

        local coordinate = Coordinate {
            x = display.contentCenterX - display.pixelWidth / 5,
            y = 0,
        }

        attributes.label = Label {
            title = title,
            coordinate = coordinate,
        }

        attributes.score = initialCount
    end,

    finalizer = function(attributes)
        attributes.label = nil
    end,
}

return Score
