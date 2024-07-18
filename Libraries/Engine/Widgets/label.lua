local display = require "display"

---@class Label
---@field create fun(group: Group)
---@field destroy fun()
---@field hide fun()
---@field show fun()
---@field updateText fun(newText: string)

---@alias LabelClass fun(title: Title, coordinate: Coordinate, event: Event?): Label
---@alias LabelIdentificator string

---@class LabelAttributes
---@field label table<any, any> | nil
---@field sceneGroup table<any, any> | nil
---@field textBackup string | nil

---@class LabelSelf: LabelAttributes, LabelMethods

---@class LabelMethods
---@field create fun(self: LabelSelf, group: Group)
---@field destroy fun(self: LabelSelf)
---@field hide fun(self: LabelSelf)
---@field show fun(self: LabelSelf)
---@field updateText fun(self: LabelSelf, newText: string)

---@alias LabelInitializer fun(attributes: LabelAttributes, title: Title, coordinate: Coordinate, event: Event?)
---@alias LabelFinalizer fun(attributes: LabelAttributes)

---@class LabelPrototype
---@field id LabelIdentificator
---@field attributes LabelAttributes
---@field methods LabelMethods
---@field initializer LabelInitializer?
---@field finalizer LabelFinalizer?

---@alias LabelMetaclass fun(prototype: LabelPrototype): LabelClass

---@type LabelMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Label = Metaclass {
    id = "label",

    attributes = {
        label = nil,
        sceneGroup = nil,
        textBackup = nil,
    },

    methods = {
        create = function(self, group)
            self.sceneGroup = group

            self.sceneGroup.insert(self.sceneGroup, self.label)
        end,

        destroy = function(self)
            self.sceneGroup.remove(self.sceneGroup, self.label)
        end,

        hide = function(self)
            self.label.isVisible = false
        end,

        show = function(self)
            self.label.isVisible = true
        end,

        updateText = function(self, newText)
            self.label.text = newText
        end,
    },

    initializer = function(attributes, title, coordinate, event)
        attributes.label = display.newText(title.text, coordinate.x, coordinate.y, title.font, title.size)

        attributes.label.setFillColor(attributes.label, title.color.red, title.color.green, title.color.blue)

        if event ~= nil then
            attributes.label.addEventListener(attributes.label, event.type, event.action)
        end

        attributes.textBackup = title.text
    end,

    finalizer = function(attributes)
        attributes.label = nil
        attributes.sceneGroup = nil
        attributes.textBackup = nil
    end,
}

return Label
