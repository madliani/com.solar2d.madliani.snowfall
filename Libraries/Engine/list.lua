local table = require "table"

local _unpack = unpack
local _next = next

---@param initialList? table
local List = function(initialList)
    local list = initialList or {}

    ---@param index? any
    local function next(index)
        return _next(list, index)
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

    local function getkeys()
        ---@type table<any>
        local keys = {}

        for key, _ in pairs(list) do
            table.insert(keys, key)
        end

        return keys
    end

    ---@param position integer
    local function getvalue(position)
        return list[position]
    end

    local function getvalues()
        ---@type table<any>
        local values = {}

        for _, value in pairs(list) do
            table.insert(values, value)
        end

        return values
    end

    ---@param pattern any
    local function getkey(pattern)
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

    local function unpack()
        return _unpack(list)
    end

    ---@class List
    ---@field next function
    ---@field find function
    ---@field foreach function
    ---@field getkey function
    ---@field getkeys function
    ---@field getvalue function
    ---@field getvalues function
    ---@field insert function
    ---@field length function
    ---@field remove function
    ---@field unpack function
    return {
        next = next,
        find = find,
        foreach = foreach,
        getkey = getkey,
        getkeys = getkeys,
        getvalue = getvalue,
        getvalues = getvalues,
        insert = insert,
        length = length,
        remove = remove,
        unpack = unpack,
    }
end

return List
