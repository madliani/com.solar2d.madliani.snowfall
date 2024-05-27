local Instance = require "Libraries.Prelude.instance"

---@param metaclass Metaclass
local Class = function(metaclass)
    ---@param initial Initial?
    return function(initial)
        return Instance(metaclass, initial)
    end
end

return Class
