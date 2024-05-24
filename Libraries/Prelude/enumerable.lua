---@generic T
---@alias Collection table<T> | T[]

---@generic T, U
---@param collection Collection<T>
---@param iteratee fun(item: T): U
local map = function(collection, iteratee)
    ---@generic U
    ---@type Collection<U>
    local mappedCollection = {}

    for key, value in pairs(collection) do
        mappedCollection[key] = iteratee(value)
    end

    return mappedCollection
end

---@generic T
---@param collection Collection<T>
---@param mixin Collection<T>
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

---@class Enumerable
return {
    map = map,
    merge = merge,
}
