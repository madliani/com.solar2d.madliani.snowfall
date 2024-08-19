local display = require "display"

---@class Snowflake: Image
---@field isUnavailable fun(): boolean
---@field update fun()

---@alias SnowflakeClass fun(path: string, scoreCounter: ScoreCounter): Snowflake
---@alias SnowflakeIdentificator string

---@class SnowflakeAttributes
---@field image table<any, any> | nil
---@field sceneGroup table<any, any> | nil
---@field scoreCounter ScoreCounter | nil

---@class SnowflakeSelf: SnowflakeAttributes, SnowflakeMethods

---@class SnowflakeMethods
---@field create fun(self: SnowflakeSelf, group: table)
---@field destroy fun(self: SnowflakeSelf)
---@field hide fun(self: SnowflakeSelf)
---@field isUnavailable fun(self: SnowflakeSelf): boolean
---@field show fun(self: SnowflakeSelf)
---@field update fun(self: SnowflakeSelf)

---@alias SnowflakeInitializer fun(attributes: SnowflakeAttributes, path: string, scoreCounter: ScoreCounter)
---@alias SnowflakeFinalizer fun(attributes: SnowflakeAttributes)

---@class SnowflakePrototype
---@field id SnowflakeIdentificator
---@field attributes SnowflakeAttributes
---@field methods SnowflakeMethods
---@field initializer SnowflakeInitializer?
---@field finalizer SnowflakeFinalizer?

---@alias SnowflakeMetaclass fun(prototype: SnowflakePrototype): SnowflakeClass

---@type SnowflakeMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Snowflake = Metaclass {
    id = "snowflake",

    attributes = {
        image = nil,
        sceneGroup = nil,
        scoreCounter = nil,
    },

    methods = {
        create = function(self, group)
            if self.image ~= nil and self.sceneGroup == nil then
                self.sceneGroup = group

                local onTap = function()
                    self.destroy(self)
                    self.scoreCounter.inc()
                end

                self.image.x = math.random(display.contentWidth)
                self.image.y = -self.image.contentHeight

                self.image.addEventListener(self.image, "tap", onTap)
                self.sceneGroup.insert(self.sceneGroup, self.image)
            end
        end,

        destroy = function(self)
            if
                self.image ~= nil
                and self.sceneGroup ~= nil
                and self.sceneGroup.remove ~= nil
                and self.image.removeSelf ~= nil
            then
                self.sceneGroup.remove(self.sceneGroup, self.image)
                self.image.removeSelf(self.image)
            end
        end,

        hide = function(self)
            if self.image ~= nil and self.image.hide ~= nil then
                self.image.hide(self.image)
            end
        end,

        isUnavailable = function(self)
            if self.image ~= nil and self.image.y ~= nil then
                return self.image.y >= display.contentHeight
            else
                return false
            end
        end,

        show = function(self)
            if self.image ~= nil and self.image.show ~= nil then
                self.image.show(self.image)
            end
        end,

        update = function(self)
            if self.image ~= nil and self.image.y ~= nil then
                local incYCoordinate = function()
                    self.image.y = self.image.y + 1
                end

                incYCoordinate()
            end
        end,
    },

    initializer = function(attributes, path, scoreCounter)
        local scale = math.random(5, 15)
        local width = display.pixelWidth / display.contentWidth * scale
        local height = display.pixelWidth / display.contentWidth * scale

        attributes.image = display.newImageRect(path, width, height)
        attributes.scoreCounter = scoreCounter
    end,

    finalizer = function(attributes)
        attributes.image = nil
        attributes.sceneGroup = nil
        attributes.scoreCounter = nil
    end,
}

return Snowflake
