---@meta

---@alias Identificator string

---@alias Attribute any
---@alias Method fun(self: Attribute, arguments: Arguments?): any

---@alias Attributes table<Attribute>
---@alias Methods table<Method>

---@class Metaclass
---@field id Identificator
---@field attributes Attributes
---@field methods Methods
