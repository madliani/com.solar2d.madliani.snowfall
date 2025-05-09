local Button = require "Libraries.Engine.Nodes.button"
local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Pool = require "Libraries.Engine.Core.pool"
local Resources = require "Sources.Game.resources"
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

            local architectsDaughterFont = Font(Resources.Fonts.architectsDaughter)

            local whiteColor = Color {
                blue = 0,
                green = 0,
                red = 0,
            }

            local title = Title {
                color = whiteColor,
                font = architectsDaughterFont,
                size = 24,
                text = items[i].text,
            }

            local coordinate = Coordinate {
                x = display.contentCenterX,
                y = 150 + gap * step,
            }

            local size = Size {
                height = 45,
                width = 190,
            }

            local button = Button {
                coordinate = coordinate,
                event = items[i].event,
                path = Resources.Images.yellowButton,
                size = size,
                title = title,
            }

            table.insert(buttonGroup, button)
        end

        attributes.menu = Pool(buttonGroup)
    end,
}

return Menu
