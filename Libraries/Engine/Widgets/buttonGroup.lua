local Button = require "Libraries.Engine.Widgets.button"
local Pool = require "Libraries.Engine.Core.pool"

---@class ButtonGroup
---@field create fun(group: Group)
---@field destroy fun()
---@field show fun()
---@field hide fun()

---@alias ButtonGroupClass fun(buttons: any[]): ButtonGroup
---@alias ButtonGroupIdentificator string

---@class ButtonGroupAttributes
---@field buttonGroup Button[] | nil
---@field pool Pool | nil

---@class ButtonGroupSelf: ButtonGroupAttributes, ButtonGroupMethods

---@class ButtonGroupMethods
---@field create fun(self: ButtonGroupSelf, group: Group)
---@field destroy fun(self: ButtonGroupSelf)
---@field show fun(self: ButtonGroupSelf)
---@field hide fun(self: ButtonGroupSelf)

---@alias ButtonGroupInitializer fun(attributes: ButtonGroupAttributes, buttons: any[])
---@alias ButtonGroupFinalizer fun(attributes: ButtonGroupAttributes)

---@class ButtonGroupPrototype
---@field id ButtonGroupIdentificator
---@field attributes ButtonGroupAttributes
---@field methods ButtonGroupMethods
---@field initializer ButtonGroupInitializer?
---@field finalizer ButtonGroupFinalizer?

---@alias ButtonGroupMetaclass fun(prototype: ButtonGroupPrototype): ButtonGroupClass

---@type ButtonGroupMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local ButtonGroup = Metaclass {
    id = "button_group",

    attributes = {
        buttonGroup = nil,
        pool = nil,
    },

    methods = {
        create = function(self, group)
            self.pool = Pool(self.buttonGroup)

            for i = 1, #self.buttonGroup, 1 do
                local button = self.buttonGroup[i]

                button.create(group)
            end
        end,

        destroy = function(self)
            self.pool.destroy()

            self.pool = nil
        end,

        show = function(self)
            self.pool.show()
        end,

        hide = function(self)
            self.pool.hide()
        end,
    },

    initializer = function(attributes, buttons)
        attributes.buttonGroup = {}

        for i = 1, #buttons, 1 do
            local path = buttons[i].path
            local title = buttons[i].title
            local size = buttons[i].size
            local coordinate = buttons[i].coordinate
            local event = buttons[i].event

            local button = Button(path, title, size, coordinate, event)

            table.insert(attributes.buttonGroup, button)
        end
    end,
}

return ButtonGroup
