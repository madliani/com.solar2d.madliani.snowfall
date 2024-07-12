local _ = require "Libraries.Prelude.enumerable"

---@class GroupManager
---@field add fun(item: GroupItem, id: GroupItemIdentificator)
---@field remove fun(id: GroupItemIdentificator)
---@field removeAll fun()

---@alias GroupManagerClass fun(): GroupManager
---@alias GroupManagerIdentificator string

---@class GroupManagerSelf: GroupManagerAttributes, GroupManagerMethods

---@class GroupManagerAttributes
---@field group Group | nil
---@field index GroupItemIndex | nil
---@field indexes GroupItemIndexes | nil

---@class GroupManagerMethods
---@field add fun(self: GroupManagerSelf, item: GroupItem, id: GroupItemIdentificator)
---@field remove fun(self: GroupManagerSelf, id: GroupItemIdentificator)
---@field removeAll fun(self: GroupManagerSelf)

---@alias GroupManagerInitializer fun(attributes: GroupManagerAttributes, group: Group)
---@alias GroupManagerFinalizer fun(attributes: GroupManagerAttributes)

---@class GroupManagerPrototype
---@field id GroupManagerIdentificator
---@field attributes GroupManagerAttributes
---@field methods GroupManagerMethods
---@field initializer GroupManagerInitializer?
---@field finalizer GroupManagerFinalizer?

---@alias GroupManagerSingleton fun(prototype: GroupManagerPrototype): GroupManagerClass

---@type GroupManagerSingleton
local Singleton = require "Libraries.Prelude.singleton"

local GroupManager = Singleton {
    id = "group_manager",

    attributes = {
        group = nil,
        index = nil,
        indexes = nil,
    },

    methods = {
        add = function(self, item, id)
            self.index = self.index + 1
            self.indexes[id] = self.index

            self.group.insert(self.group, self.index, item)
        end,

        remove = function(self, id)
            local index = self.indexes[id]

            self.group.remove(self.group, index)

            self.indexes[id] = nil
        end,

        removeAll = function(self)
            _.each(self.indexes, function(index)
                self.group.remove(self.group, index)
            end)

            _.fillInto(self.indexes, nil)
        end,
    },

    initializer = function(attributes, group)
        attributes.group = group
        attributes.index = 0
        attributes.indexes = {}
    end,
}

return GroupManager
