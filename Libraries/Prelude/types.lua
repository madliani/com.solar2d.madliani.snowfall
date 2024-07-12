---@meta

---@alias Arguments any[]
---@alias Function fun(...: Arguments?): any
---@alias Class fun(...: Arguments?): Object
---@alias Identificator string

---@alias PrototypeIdentificator Identificator
---@alias PrototypeAttributeIdentificator Identificator
---@alias PrototypeMethodIdentificator Identificator
---@alias PrototypeAttribute any
---@alias PrototypeMethod fun(self: PrototypeSelf, ...: Arguments?): any
---@alias PrototypeAttributes table<PrototypeAttributeIdentificator, PrototypeAttribute>
---@alias PrototypeMethods table<PrototypeMethodIdentificator, PrototypeMethod>
---@alias PrototypeSelf table<string, any>
---@alias PrototypeInitializer fun(attributes: PrototypeAttributes, ...: Arguments?)
---@alias PrototypeFinalizer fun(attributes: PrototypeAttributes, methods: PrototypeMethods?)

---@class Prototype
---@field id PrototypeIdentificator
---@field attributes PrototypeAttributes
---@field methods PrototypeMethods
---@field initializer PrototypeInitializer?
---@field finalizer PrototypeFinalizer?
