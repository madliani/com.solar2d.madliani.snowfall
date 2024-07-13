---@meta

---@alias Arguments any[]
---@alias Function fun(...: Arguments?): any
---@alias Class fun(...: Arguments?): Object
---@alias Identificator string
---@alias FieldId Identificator

---@alias PrototypeId Identificator
---@alias PrototypeFieldId FieldId
---@alias PrototypeAttribute any
---@alias PrototypeMethod fun(self: PrototypeSelf, ...: Arguments?): any
---@alias PrototypeAttributes table<PrototypeFieldId, PrototypeAttribute>
---@alias PrototypeMethods table<PrototypeFieldId, PrototypeMethod>
---@alias PrototypeSelf table<PrototypeFieldId, any>
---@alias PrototypeInitializer fun(attributes: PrototypeAttributes, ...: Arguments?)
---@alias PrototypeFinalizer fun(attributes: PrototypeAttributes, methods: PrototypeMethods?)

---@class Prototype
---@field id PrototypeId
---@field attributes PrototypeAttributes
---@field methods PrototypeMethods
---@field initializer PrototypeInitializer?
---@field finalizer PrototypeFinalizer?
