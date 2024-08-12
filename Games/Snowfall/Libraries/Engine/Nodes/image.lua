local Anchor = require "Libraries.Engine.Core.anchor"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Scale = require "Libraries.Engine.Core.scale"
local Size = require "Libraries.Engine.Core.size"
local display = require "display"

---@class Image
---@field create fun(group: Group)
---@field destroy fun()
---@field getAnchor fun(): Anchor
---@field getCoordinate fun(): Coordinate
---@field getRotation fun(): Rotation
---@field getScale fun(): Scale
---@field getSize fun(): Size
---@field getTransparency fun(): Transparency
---@field hide fun()
---@field setAnchor fun(anchor: Anchor)
---@field setCoordinate fun(coordinate: Coordinate)
---@field setRotation fun(rotation: Rotation)
---@field setScale fun(scale: Scale)
---@field setSize fun(size: Size)
---@field setTransparency fun(transparency: Transparency)
---@field show fun()

---@alias ImageClass fun(path: ImagePath, size: Size, coordinate: Coordinate, event: Event?): Image
---@alias ImageIdentificator string

---@class ImageAttributes
---@field image table<any, any> | nil
---@field sceneGroup table<any, any> | nil

---@class ImageSelf: ImageAttributes, ImageMethods

---@class ImageMethods
---@field create fun(self: ImageSelf, group: Group, event: Event?)
---@field destroy fun(self: ImageSelf)
---@field getAnchor fun(self: ImageSelf): Anchor
---@field getCoordinate fun(self: ImageSelf): Coordinate
---@field getRotation fun(self: ImageSelf): Rotation
---@field getScale fun(self: ImageSelf): Scale
---@field getSize fun(self: ImageSelf): Size
---@field getTransparency fun(self: ImageSelf): Transparency
---@field hide fun(self: ImageSelf)
---@field setAnchor fun(self: ImageSelf, anchor: Anchor)
---@field setCoordinate fun(self: ImageSelf, coordinate: Coordinate)
---@field setRotation fun(self: ImageSelf, rotation: Rotation)
---@field setScale fun(self: ImageSelf, scale: Scale)
---@field setSize fun(self: ImageSelf, size: Size)
---@field setTransparency fun(self: ImageSelf, transparency: Transparency)
---@field show fun(self: ImageSelf)

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
            self.sceneGroup.remove(self.sceneGroup, self.image)
            self.image.removeSelf(self.image)
        end,

        getAnchor = function(self)
            return Anchor {
                x = self.image.anchorX,
                y = self.image.anchorY
            }
        end,

        getCoordinate = function(self)
            return Coordinate {
                x = self.image.x,
                y = self.image.y
            }
        end,

        getRotation = function(self)
            return self.image.rotation
        end,

        getScale = function(self)
            return Scale {
                x = self.image.xScale,
                y = self.image.yScale
            }
        end,

        getSize = function(self)
            return Size {
                width = self.image.width,
                height = self.image.height
            }
        end,

        getTransparency = function(self)
            return self.image.alpha
        end,

        hide = function(self)
            self.image.isVisible = false
        end,

        setAnchor = function(self, anchor)
            self.image.anchorX = anchor.x
            self.image.anchorY = anchor.y
        end,

        setCoordinate = function(self, coordinate)
            self.image.translate(self.image, coordinate.x, coordinate.y)
        end,

        setRotation = function(self, rotation)
            self.image.rotate(self.image, rotation)
        end,

        setScale = function(self, scale)
            self.image.xScale = scale.x
            self.image.yScale = scale.y
        end,

        setSize = function(self, size)
            self.image.width = size.width
            self.image.height = size.height
        end,

        setTransparency = function(self, transparency)
            self.image.alpha = transparency
        end,

        show = function(self)
            self.image.isVisible = true
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
