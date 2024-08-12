local Button = require "Libraries.Engine.Nodes.button"
local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Pool = require "Libraries.Engine.Core.pool"
local Resources = require "resources"
local Size = require "Libraries.Engine.Core.size"
local Title = require "Libraries.Engine.Core.title"
local display = require "display"

---@class Menu: Pool

---@alias MenuClass fun(items: table<any>[]): Menu
---@alias MenuIdentificator string

---@class MenuAttributes
---@field menu Pool | nil

---@class MenuMethods
---@field create fun(self: MenuSelf, group: table)
---@field destroy fun(self: MenuSelf)
---@field show fun(self: MenuSelf)
---@field hide fun(self: MenuSelf)

---@class MenuSelf: MenuAttributes, MenuMethods

---@alias MenuInitializer fun(attributes: MenuAttributes, items: table<any>[])
---@alias MenuFinalizer fun(attributes: MenuAttributes)

---@class MenuPrototype
---@field id MenuIdentificator
---@field attributes MenuAttributes
---@field methods MenuMethods
---@field initializer MenuInitializer?
---@field finalizer MenuFinalizer?

---@alias MenuMetaclass fun(prototype: MenuPrototype): MenuClass

---@type MenuMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Menu = Metaclass {
    id = "menu",

    attributes = {
        menu = nil,
    },

    methods = {
        create = function(self, group)
            self.menu.create(group)
        end,

        destroy = function(self)
            self.menu.destroy()
        end,

        show = function(self)
            self.menu.show()
        end,

        hide = function(self)
            self.menu.hide()
        end,
    },

    initializer = function(attributes, items)
        local buttonGroup = {}

        for i = 1, #items, 1 do
            local step = i - 1
            local gap = 100
            local font = Font(Resources.Fonts.main)

            local color = Color {
                red = 0,
                green = 0,
                blue = 0
            }

            local size = Size(190, 45)
            local title = Title(items[i].text, font, color, 24)
            local coordinate = Coordinate(display.contentCenterX, 150 + gap * step)
            local button = Button(Resources.Images.yellowButton, title, size, coordinate, items[i].event)

            table.insert(buttonGroup, button)
        end

        attributes.menu = Pool(buttonGroup)
    end,
}

return Menu
