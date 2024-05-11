local table = require "table"

local _unpack = unpack

---@param initialList? table
local List = function(initialList)
    local list = initialList or {}

    local function unpack()
        return _unpack(list)
    end

    ---@param callback function
    local function find(callback)
        for _, value in pairs(list) do
            if callback(value) == true then
                return value
            end
        end

        return nil
    end

    ---@param callback function
    local function foreach(callback)
        for key, value in pairs(list) do
            ---@param newValue any
            local function set(newValue)
                list[key] = newValue
            end

            callback(value, set)
        end
    end

    local function getKeys()
        ---@type table<any>
        local keys = {}

        for key, _ in pairs(list) do
            table.insert(keys, key)
        end

        return keys
    end

    ---@param position integer
    local function getValue(position)
        return list[position]
    end

    local function getValues()
        ---@type table<any>
        local values = {}

        for _, value in pairs(list) do
            table.insert(values, value)
        end

        return values
    end

    ---@param pattern any
    local function index(pattern)
        for key, value in pairs(list) do
            if value == pattern then
                return key
            end
        end

        return nil
    end

    ---@param value any
    local function insert(value)
        table.insert(list, value)
    end

    local function length()
        return #list
    end

    ---@param position integer
    local function remove(position)
        table.remove(list, position)
    end

    ---@class List
    ---@field unpack function
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
        unpack = unpack,
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
