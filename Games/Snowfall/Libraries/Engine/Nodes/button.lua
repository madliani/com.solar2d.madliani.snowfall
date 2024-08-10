local Image = require "Libraries.Engine.Nodes.image"
local Label = require "Libraries.Engine.Nodes.label"

---@class Button
---@field create fun(group: Group)
---@field destroy fun()
---@field show fun()
---@field hide fun()

---@alias ButtonClass fun(path: ImagePath, title: Title, size: Size, coordinate: Coordinate, event: Event): Button
---@alias ButtonIdentificator string

---@class ButtonAttributes
---@field image Image | nil
---@field label Label | nil
---@field sceneGroup table | nil

---@class ButtonSelf: ButtonAttributes, ButtonMethods

---@class ButtonMethods
---@field create fun(self: ButtonSelf, group: Group)
---@field destroy fun(self: ButtonSelf)
---@field show fun(self: ButtonSelf)
---@field hide fun(self: ButtonSelf)

---@alias ButtonInitializer fun(attributes: ButtonAttributes, path: ImagePath, title: Title, size: Size, coordinate: Coordinate, event: Event)
---@alias ButtonFinalizer fun(attributes: ButtonAttributes)

---@class ButtonPrototype
---@field id ButtonIdentificator
---@field attributes ButtonAttributes
---@field methods ButtonMethods
---@field initializer ButtonInitializer?
---@field finalizer ButtonFinalizer?

---@alias ButtonMetaclass fun(prototype: ButtonPrototype): ButtonClass

---@type ButtonMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Button = Metaclass {
    id = "button",

    attributes = {
        image = nil,
        label = nil,
        sceneGroup = nil,
    },

    methods = {
        create = function(self, group)
            if self.image ~= nil and self.label ~= nil then
                self.image.create(group)
                self.label.create(group)

                self.sceneGroup = group
            end
        end,

        destroy = function(self)
            if self.image ~= nil and self.label ~= nil and self.sceneGroup ~= nil then
                self.image.destroy()
                self.label.destroy()

                self.image = nil
                self.label = nil
                self.sceneGroup = nil
            end
        end,

        hide = function(self)
            if self.image ~= nil and self.label ~= nil then
                self.image.hide()
                self.label.hide()
            end
        end,

        show = function(self)
            if self.image ~= nil and self.label ~= nil then
                self.image.show()
                self.label.show()
            end
        end,
    },

    initializer = function(attributes, path, title, size, coordinate, event)
        attributes.image = Image(path, size, coordinate, event)
        attributes.label = Label(title, coordinate)
    end,
}

return Button
