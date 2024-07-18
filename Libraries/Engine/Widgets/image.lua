local display = require "display"

---@class Image
---@field create fun(group: Group)
---@field destroy fun()
---@field show fun()
---@field hide fun()

---@alias ImageClass fun(path: ImagePath, size: Size, coordinate: Coordinate, event: Event?): Image
---@alias ImageIdentificator string

---@class ImageAttributes
---@field image table<any, any> | nil
---@field sceneGroup table<any, any> | nil

---@class ImageSelf: ImageAttributes, ImageMethods

---@class ImageMethods
---@field create fun(self: ImageSelf, group: Group, event: Event?)
---@field destroy fun(self: ImageSelf)
---@field show fun(self: ImageSelf)
---@field hide fun(self: ImageSelf)

---@alias ImageInitializer fun(attributes: ImageAttributes, path: ImagePath, size: Size, coordinate: Coordinate, event: Event?)
---@alias ImageFinalizer fun(attributes: ImageAttributes)

---@class ImagePrototype
---@field id ImageIdentificator
---@field attributes ImageAttributes
---@field methods ImageMethods
---@field initializer ImageInitializer?
---@field finalizer ImageFinalizer?

---@alias ImageMetaclass fun(prototype: ImagePrototype): ImageClass

---@type ImageMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Image = Metaclass {
    id = "image",

    attributes = {
        image = nil,
        sceneGroup = nil,
    },

    methods = {
        create = function(self, group)
            self.sceneGroup = group

            self.sceneGroup.insert(self.sceneGroup, self.image)
        end,

        destroy = function(self)
            if self.image ~= nil and self.sceneGroup ~= nil then
                self.sceneGroup.remove(self.sceneGroup, self.image)
                self.image.removeSelf(self.image)
            end
        end,

        show = function(self)
            self.image.isVisible = true
        end,

        hide = function(self)
            self.image.isVisible = false
        end,
    },

    initializer = function(attributes, path, size, coordinate, event)
        attributes.image = display.newImageRect(path, size.width, size.height)

        attributes.image.translate(attributes.image, coordinate.x, coordinate.y)

        if event ~= nil then
            attributes.image.addEventListener(attributes.image, event.type, event.action)
        end
    end,

    finalizer = function(attributes)
        attributes.image = nil
        attributes.sceneGroup = nil
    end,
}

return Image
