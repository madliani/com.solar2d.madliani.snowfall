---@param action function
---@param type string
local Event = function(action, type)
    ---@class Event
    ---@field action function
    ---@field type string
    return {
        action = action,
        type = type,
    }
end

return Event
