local table = require "table"

---@param values? any[]
local Array = function(values)
    local array = values or {}
    local length = #array

    ---@param f function
    local function forEach(f)
        local i = 1

        while i <= length do
            local value = array[i]

            ---@param newValue any
            local function set(newValue)
                array[i] = newValue
            end

            f(value, set)

            i = i + 1
        end
    end

    ---@param position integer
    local function get(position)
        return array[position]
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
    ---@field forEach function
    ---@field get function
    ---@field insert function
    ---@field length function
    ---@field remove function
    return {
        forEach = forEach,
        get = get,
        insert = insert,
        len = len,
        remove = remove,
    }
end

return Array
