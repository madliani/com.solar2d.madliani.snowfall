local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Label = require "Libraries.Engine.Nodes.label"
local Resources = require "resources"
local Title = require "Libraries.Engine.Core.title"
local display = require "display"

---@class Heading: Label

---@alias HeadingClass fun(text: string): Heading
---@alias HeadingIdentificator string

---@class HeadingAttributes
---@field label Label | nil

---@class HeadingSelf: HeadingAttributes, HeadingMethods

---@class HeadingMethods
---@field create fun(self: HeadingSelf, group: table)
---@field destroy fun(self: HeadingSelf)
---@field show fun(self: HeadingSelf)
---@field hide fun(self: HeadingSelf)
---@field updateText fun(self: HeadingSelf, newText: string)

---@alias HeadingInitializer fun(attributes: HeadingAttributes, text: string)
---@alias HeadingFinalizer fun(attributes: HeadingAttributes)

---@class HeadingPrototype
---@field id HeadingIdentificator
---@field attributes HeadingAttributes
---@field methods HeadingMethods
---@field initializer HeadingInitializer?
---@field finalizer HeadingFinalizer?

---@alias HeadingMetaclass fun(prototype: HeadingPrototype): HeadingClass

---@type HeadingMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Heading = Metaclass {
    id = "heading",

    attributes = {
        label = nil,
    },

    methods = {
        create = function(self, group)
            self.label.create(group)
        end,

        destroy = function(self)
            self.label.destroy()
        end,

        show = function(self)
            self.label.show()
        end,

        hide = function(self)
            self.label.hide()
        end,

        updateText = function(self, newText)
            self.label.updateText(newText)
        end,
    },

    initializer = function(attributes, text)
        local architectsDaughterFont = Font(Resources.Fonts.main)

        local blackColor = Color {
            red = 1,
            green = 1,
            blue = 1
        }

        local coordinate = Coordinate {
            x = display.contentCenterX,
            y = display.contentCenterY - 200
        }

        local size = 48
        local title = Title(text, architectsDaughterFont, blackColor, size)

        attributes.label = Label(title, coordinate)
    end,

    finalizer = function(attributes)
        attributes.label = nil
    end,
}

return Heading
