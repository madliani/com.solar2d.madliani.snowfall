local table = require "table"

---@param values? any[]
local Table = function(values)
    local array = values or {}
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

    ---@param position integer
    local function get(position)
        return array[position]
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
    ---@field get function
    ---@field index function
    ---@field insert function
    ---@field length function
    ---@field remove function
    return {
        find = find,
        forEach = forEach,
        get = get,
        index = index,
        insert = insert,
        len = len,
        remove = remove,
    }
end

return Table
