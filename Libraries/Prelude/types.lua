---@meta

---@alias Arguments any[]
---@alias Function fun(...: Arguments?): any

---@alias Identificator string
---@alias Attribute any
---@alias Method fun(self: Self, ...: Arguments?): any
---@alias Attributes table<string, Attribute>
---@alias Methods table<string, Method>
---@alias Self table<unknown, any>
---@alias Initializer fun(attributes: Attributes, ...: Arguments?)
---@alias Finalizer fun(attributes: Attributes, methods: Methods?)

---@class Prototype
---@field id Identificator
---@field attributes Attributes
---@field methods Methods
---@field initializer Initializer?
---@field finalizer Finalizer?
