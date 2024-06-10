---@param task Task
---@param event Event?
local Loop = function(task, event)
    ---@class Loop
    ---@field task Task
    ---@field event Event?
    return {
        task = task,
        event = event,
    }
end

return Loop
