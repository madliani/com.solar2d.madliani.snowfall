local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Label = require "Libraries.Engine.Nodes.label"
local Resources = require "Sources.resources"
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
        local architectsDaughterFont = Font(Resources.Fonts.architectsDaughter)

        local whiteColor = Color {
            blue = 0,
            green = 0,
            red = 0,
        }

        local title = Title {
            color = whiteColor,
            font = architectsDaughterFont,
            size = 48,
            text = tostring(initialCount),
        }

        local coordinate = Coordinate {
            x = display.contentCenterX - display.pixelWidth / 5,
            y = 0,
        }

        attributes.label = Label {
            coordinate = coordinate,
            title = title,
        }

        attributes.score = initialCount
    end,

    finalizer = function(attributes)
        attributes.label = nil
    end,
}

return Score
