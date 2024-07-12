---@alias CollectionItemKey unknown
---@alias CollectionItemValue any
---@alias Collection table<CollectionItemKey, CollectionItemValue> | CollectionItemValue[]

---@alias Iteratee fun(value: CollectionItemValue, key: CollectionItemKey?): any

---@alias Each fun(collection: Collection, iteratee: Iteratee)
---@alias Fill fun(collection: Collection, value: CollectionItemValue): Collection
---@alias FillInto fun(collection: Collection, value: CollectionItemValue)
---@alias Map fun(collection: Collection, iteratee: Iteratee): Collection
---@alias Merge fun(collection: Collection, mixin: Collection): Collection

---@class Enumerable
---@field each Each
---@field fill Fill
---@field fillInto FillInto
---@field map Map
---@field merge Merge

---@type Each
local each = function(collection, iteratee)
    for key, value in pairs(collection) do
        iteratee(value, key)
    end
end

---@type Fill
local fill = function(collection, value)
    local filledCollection = {}

    for key, _ in pairs(collection) do
        filledCollection[key] = value
    end

    return filledCollection
end

---@type FillInto
local fillInto = function(collection, value)
    for key, _ in pairs(collection) do
        collection[key] = value
    end
end

---@type Map
local map = function(collection, iteratee)
    local mappedCollection = {}

    for key, value in pairs(collection) do
        mappedCollection[key] = iteratee(value, key)
    end

    return mappedCollection
end

---@type Merge
local merge = function(collection, mixin)
    local mergedCollection = {}

    for key, value in pairs(collection) do
        mergedCollection[key] = value
    end

    for key, value in pairs(mixin) do
        mergedCollection[key] = value
    end

    return mergedCollection
end

---@type Enumerable
local Enumerable = {
    each = each,
    fill = fill,
    fillInto = fillInto,
    map = map,
    merge = merge,
}

return Enumerable
