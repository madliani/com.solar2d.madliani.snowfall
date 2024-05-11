local table = require "table"

---@param initialArray? table
local Array = function(initialArray)
    local array = initialArray or {}
    local length = #array

    ---@param func function
    local function find(func)
        for _, value in pairs(array) do
            if func(value) == true then
                return value
            end
        end

        return nil
    end

    ---@param func function
    local function forEach(func)
        for key, value in pairs(array) do
            ---@param newValue any
            local function set(newValue)
                array[key] = newValue
            end

            func(value, set)
        end
    end

    local function getKeys()
        ---@type table<any>
        local keys = {}

        for key, _ in pairs(array) do
            table.insert(keys, key)
        end

        return keys
    end

    ---@param position integer
    local function getValue(position)
        return array[position]
    end

    local function getValues()
        ---@type table<any>
        local values = {}

        for _, value in pairs(array) do
            table.insert(values, value)
        end

        return values
    end

    ---@param pattern any
    local function index(pattern)
        for key, value in pairs(array) do
            if value == pattern then
                return key
            end
        end

        return nil
    end

    ---@param value any
    local function insert(value)
        table.insert(array, value)

        length = #array
    end

    local function len()
        return length
    end

    ---@param position integer
    local function remove(position)
        table.remove(array, position)

        length = #array
    end

    ---@class Array
    ---@field find function
    ---@field forEach function
    ---@field getKeys function
    ---@field getValue function
    ---@field getValues function
    ---@field index function
    ---@field insert function
    ---@field len function
    ---@field remove function
    return {
        find = find,
        forEach = forEach,
        getKeys = getKeys,
        getValue = getValue,
        getValues = getValues,
        index = index,
        insert = insert,
        len = len,
        remove = remove,
    }
end

return Array
