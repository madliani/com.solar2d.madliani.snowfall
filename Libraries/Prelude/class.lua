local Instance = require "Libraries.Prelude.instance"

---@param metaclass Metaclass
local Class = function(metaclass)
    ---@param initial InitialArguments?
    return function(initial)
        return Instance(metaclass, initial)
    end
end

return Class
