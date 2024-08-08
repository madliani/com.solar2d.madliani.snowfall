---@class Pool
---@field create fun(group: table<any, any>)
---@field destroy fun()
---@field show fun()
---@field hide fun()

---@alias PoolClass fun(pool: any[]): Pool
---@alias PoolIdentificator string

---@class PoolAttributes
---@field pool any[] | nil

---@class PoolSelf: PoolAttributes, PoolMethods

---@class PoolMethods
---@field create fun(self: PoolSelf, group: table)
---@field destroy fun(self: PoolSelf)
---@field show fun(self: PoolSelf)
---@field hide fun(self: PoolSelf)

---@alias PoolInitializer fun(attributes: PoolAttributes, objects: any[])
---@alias PoolFinalizer fun(attributes: PoolAttributes)

---@class PoolPrototype
---@field id PoolIdentificator
---@field attributes PoolAttributes
---@field methods PoolMethods
---@field initializer PoolInitializer?
---@field finalizer PoolFinalizer?

---@alias PoolMetaclass fun(prototype: PoolPrototype): PoolClass

---@type PoolMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local Pool = Metaclass {
    id = "pool",

    attributes = {
        pool = nil,
    },

    methods = {
        create = function(self, group)
            if self.pool ~= nil and #self.pool > 0 then
                for i = 1, #self.pool, 1 do
                    if group ~= nil then
                        self.pool[i].create(group)
                    else
                        self.pool[i].create()
                    end
                end
            end
        end,

        destroy = function(self)
            if self.pool ~= nil and #self.pool > 0 then
                for i = 1, #self.pool, 1 do
                    self.pool[i].destroy()
                end
            end
        end,

        show = function(self)
            if self.pool ~= nil and #self.pool > 0 then
                for i = 1, #self.pool, 1 do
                    local object = self.pool[i]

                    if object.show ~= nil then
                        object.show()
                    elseif object.resume ~= nil then
                        object.resume()
                    end
                end
            end
        end,

        hide = function(self)
            if self.pool ~= nil and #self.pool > 0 then
                for i = 1, #self.pool, 1 do
                    local object = self.pool[i]

                    if object.hide ~= nil then
                        object.hide()
                    elseif object.pause ~= nil then
                        object.pause()
                    end
                end
            end
        end,
    },

    initializer = function(attributes, pool)
        attributes.pool = pool
    end,
}

return Pool
