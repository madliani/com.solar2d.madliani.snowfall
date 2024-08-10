---@meta

---@alias Identificator string
---@alias FieldId Identificator
---@alias ObjectFieldId FieldId
---@alias Arguments any[]
---@alias Function fun(...: Arguments?): any
---@alias Object table<ObjectFieldId, any>
---@alias Class fun(...: Arguments?): Object

---@alias PrototypeId Identificator
---@alias PrototypeFieldId FieldId
---@alias PrototypeAttribute any
---@alias PrototypeMethod fun(self: PrototypeSelf, ...: Arguments?): any
---@alias PrototypeAttributes table<PrototypeFieldId, PrototypeAttribute>
---@alias PrototypeMethods table<PrototypeFieldId, PrototypeMethod>
---@alias PrototypeSelf table<PrototypeFieldId, any>
---@alias PrototypeInitializer fun(attributes: PrototypeAttributes, ...: Arguments?)
---@alias PrototypeFinalizer fun(attributes: PrototypeAttributes, methods: PrototypeMethods?)
---@alias PrototypeWrapper fun(...: Arguments?): Object
---@alias PrototypeMaker fun(object: Object): Object

---@class MetaclassPrototype
---@field id PrototypeId
---@field attributes PrototypeAttributes
---@field methods PrototypeMethods
---@field initializer PrototypeInitializer
---@field finalizer PrototypeFinalizer?

---@class SingletonPrototype
---@field id PrototypeId
---@field attributes PrototypeAttributes
---@field methods PrototypeMethods
---@field initializer PrototypeInitializer
---@field finalizer PrototypeFinalizer?

---@class AdapterPrototype
---@field id PrototypeId
---@field wrapper PrototypeWrapper

---@class ContainerPrototype
---@field id PrototypeId
---@field maker PrototypeMaker
