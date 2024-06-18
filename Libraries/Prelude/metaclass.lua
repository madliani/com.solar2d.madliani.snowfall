---@meta

---@alias Initial any
---@alias Identificator string
---@alias Attribute any
---@alias Method fun(self: Self, ...: Arguments?): any
---@alias Attributes table<Attribute>
---@alias Methods table<Method>
---@alias Self table<any>
---@alias Initializer fun(initial: Initial, attributes: Attributes, methods: Methods?)
---@alias Finalizer fun(attributes: Attributes, methods: Methods?)

---@class Metaclass
---@field id Identificator
---@field attributes Attributes
---@field methods Methods
---@field initializer Initializer?
---@field finalizer Finalizer?
