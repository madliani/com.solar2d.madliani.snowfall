local table = require "table"

---@param initialList? table
local List = function(initialList)
    local array = initialList or {}

    ---@param callback function
    local function find(callback)
        for _, value in pairs(array) do
            if callback(value) == true then
                return value
            end
        end

        return nil
    end

    ---@param callback function
    local function foreach(callback)
        for key, value in pairs(array) do
            ---@param newValue any
            local function set(newValue)
                array[key] = newValue
            end

            callback(value, set)
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
    end

    local function length()
        return #array
    end

    ---@param position integer
    local function remove(position)
        table.remove(array, position)
    end

    ---@class List
    ---@field find function
    ---@field foreach function
    ---@field getKeys function
    ---@field getValue function
    ---@field getValues function
    ---@field index function
    ---@field insert function
    ---@field length function
    ---@field remove function
    return {
        find = find,
        foreach = foreach,
        getKeys = getKeys,
        getValue = getValue,
        getValues = getValues,
        index = index,
        insert = insert,
        length = length,
        remove = remove,
    }
end

return List
