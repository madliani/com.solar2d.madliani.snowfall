---@param action function
---@param time number
local Task = function(action, time)
    ---@class Task
    ---@field action function
    ---@field time number
    return {
        action = action,
        time = time,
    }
end

return Task
