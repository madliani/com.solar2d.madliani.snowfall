local Coordinate = require "Libraries.Engine.Core.coordinate"
local Image = require "Libraries.Engine.Widgets.image"
local Size = require "Libraries.Engine.Core.size"
local display = require "display"

---@class Background
---@field create fun(group: Group)
---@field destroy fun()
---@field show fun()
---@field hide fun()

---@alias ImagePath string
---@alias BackgroundClass fun(path: ImagePath): Background
---@alias BackgroundIdentificator string

---@class BackgroundAttributes
---@field image Image | nil

---@class BackgroundSelf: BackgroundAttributes, BackgroundMethods

---@class BackgroundMethods
---@field create fun(self: BackgroundSelf, group: Group)
---@field destroy fun(self: BackgroundSelf)
---@field show fun(self: BackgroundSelf)
---@field hide fun(self: BackgroundSelf)

---@alias BackgroundInitializer fun(attributes: BackgroundAttributes, path: ImagePath)
---@alias BackgroundFinalizer fun(attributes: BackgroundAttributes)

---@class BackgroundPrototype
---@field id BackgroundIdentificator
---@field attributes BackgroundAttributes
---@field methods BackgroundMethods
---@field initializer BackgroundInitializer?
---@field finalizer BackgroundFinalizer?

---@alias BackgroundMetaclass fun(prototype: BackgroundPrototype): BackgroundClass

---@type BackgroundMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Background = Metaclass {
    id = "background",

    attributes = {
        image = nil,
    },

    methods = {
        create = function(self, group)
            if self.image ~= nil then
                self.image.create(group)
            end
        end,

        destroy = function(self)
            if self.image ~= nil then
                self.image.destroy()

                self.image = nil
            end
        end,

        hide = function(self)
            if self.image ~= nil then
                self.image.hide()
            end
        end,

        show = function(self)
            if self.image ~= nil then
                self.image.show()
            end
        end,
    },

    initializer = function(attributes, path)
        attributes.image = Image(
            path,
            Size(display.pixelWidth, display.pixelHeight),
            Coordinate(display.contentCenterX, display.contentCenterY)
        )
    end,
}

return Background
