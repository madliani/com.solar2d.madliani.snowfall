---@alias Collection table<unknown, any> | any[]

---@alias Iteratee fun(item: any, id: unknown?): any

---@alias Each fun(collection: Collection, iteratee: Iteratee)
---@alias Map fun(collection: Collection, iteratee: Iteratee): Collection
---@alias Merge fun(collection: Collection, mixin: Collection): Collection

---@class Enumerable
---@field each Each
---@field map Map
---@field merge Merge

---@type Each
local each = function(collection, iteratee)
    for key, value in pairs(collection) do
        iteratee(value, key)
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
return {
    each = each,
    map = map,
    merge = merge,
}
