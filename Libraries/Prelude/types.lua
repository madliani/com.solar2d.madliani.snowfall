---@meta

---@alias Arguments any[]
---@alias Function fun(...: Arguments?): any
---@alias Class fun(...: Arguments?): Object

---@alias PrototypeIdentificator string
---@alias PrototypeAttribute any
---@alias PrototypeMethod fun(self: PrototypeSelf, ...: Arguments?): any
---@alias PrototypeAttributes table<string, PrototypeAttribute>
---@alias PrototypeMethods table<string, PrototypeMethod>
---@alias PrototypeSelf table<unknown, any>
---@alias PrototypeInitializer fun(attributes: PrototypeAttributes, ...: Arguments?)
---@alias PrototypeFinalizer fun(attributes: PrototypeAttributes, methods: PrototypeMethods?)

---@class Prototype
---@field id PrototypeIdentificator
---@field attributes PrototypeAttributes
---@field methods PrototypeMethods
---@field initializer PrototypeInitializer?
---@field finalizer PrototypeFinalizer?
