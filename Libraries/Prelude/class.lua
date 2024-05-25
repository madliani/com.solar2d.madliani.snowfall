---@meta

---@alias Identificator string

---@alias Attribute any
---@alias Method fun(self: Attributes, args: any[]?): any

---@alias Attributes table<Attribute>
---@alias Methods table<Method>

---@class Class
---@field attributes Attributes
---@field methods Methods?
