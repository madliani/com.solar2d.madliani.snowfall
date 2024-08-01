---@param action function
---@param time integer
local Task = function(action, time)
    ---@class Task
    ---@field action function
    ---@field time integer
    return {
        action = action,
        time = time,
    }
end

return Task
