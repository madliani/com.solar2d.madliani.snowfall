---@meta

---@alias Initial any
---@alias Identificator string
---@alias Attribute any
---@alias Method fun(self: Self, ...: Arguments?): any
---@alias Attributes table<string, Attribute>
---@alias Methods table<string, Method>
---@alias Self table<unknown, any>
---@alias Initializer fun(initial: Initial, attributes: Attributes, methods: Methods?)
---@alias Finalizer fun(attributes: Attributes, methods: Methods?)

---@class Prototype
---@field id Identificator
---@field attributes Attributes
---@field methods Methods
---@field initializer Initializer?
---@field finalizer Finalizer?
