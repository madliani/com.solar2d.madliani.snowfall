local Pool = require "Libraries.Engine.Core.pool"

---@class ButtonGroup
---@field create fun(group: Group)
---@field destroy fun()
---@field show fun()
---@field hide fun()

---@alias ButtonGroupClass fun(buttons: Button[]): ButtonGroup
---@alias ButtonGroupIdentificator string

---@class ButtonGroupAttributes
---@field buttonGroup Pool | nil

---@class ButtonGroupSelf: ButtonGroupAttributes, ButtonGroupMethods

---@class ButtonGroupMethods
---@field create fun(self: ButtonGroupSelf, group: Group)
---@field destroy fun(self: ButtonGroupSelf)
---@field show fun(self: ButtonGroupSelf)
---@field hide fun(self: ButtonGroupSelf)

---@alias ButtonGroupInitializer fun(attributes: ButtonGroupAttributes, buttons: Button[])
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
    },

    methods = {
        create = function(self, group)
            self.buttonGroup.create(group)
        end,

        destroy = function(self)
            self.buttonGroup.destroy()

            self.buttonGroup = nil
        end,

        show = function(self)
            self.buttonGroup.show()
        end,

        hide = function(self)
            self.buttonGroup.hide()
        end,
    },

    initializer = function(attributes, buttons)
        attributes.buttonGroup = Pool(buttons)
    end,
}

return ButtonGroup
