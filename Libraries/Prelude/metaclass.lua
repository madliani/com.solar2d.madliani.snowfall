---@meta

---@alias Identificator string
---@alias Attribute any
---@alias Initial any
---@alias Method fun(self: Attribute, arguments: Arguments?): any
---@alias Initializer fun(initial: Initial, attributes: Attributes, methods: Methods?)
---@alias Finalizer fun(attributes: Attributes, methods: Methods?)

---@alias Attributes table<Attribute>
---@alias Methods table<Method | Initializer | Finalizer>

---@class Metaclass
---@field id Identificator
---@field attributes Attributes
---@field methods Methods
---@field initializer Initializer?
---@field finalizer Finalizer?
