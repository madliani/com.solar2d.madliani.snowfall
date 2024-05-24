local _ = require "Libraries.Prelude.enumerable"

---@alias Instance table<Method>

---@param class Class
---@param initial? unknown[]
local Instance = function(class, initial)
    ---@type Instance
    return _.map(class.methods, function(method)
        return function()
            method(initial)
        end
    end)
end

return Instance
