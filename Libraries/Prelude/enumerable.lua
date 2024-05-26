---@generic T
---@alias Collection table<T> | T[]

---@generic T, U
---@alias Iteratee fun(item: T): U

---@generic T, U
---@alias Map fun(collection: Collection<T>, iteratee: Iteratee<T, U>): Collection<U>
---@alias Merge fun(collection: Collection<T>, mixin: Collection<T>): Collection<T>

---@class Enumerable
---@field map Map
---@field merge Merge

---@type Map
local map = function(collection, iteratee)
    ---@generic U
    ---@type Collection<U>
    local mappedCollection = {}

    for key, value in pairs(collection) do
        mappedCollection[key] = iteratee(value)
    end

    return mappedCollection
end

---@type Merge
local merge = function(collection, mixin)
    ---@generic T
    ---@type Collection<T>
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
local enumerable = {
    map = map,
    merge = merge,
}

return enumerable
