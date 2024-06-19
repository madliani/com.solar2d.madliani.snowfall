local Instance = require "Libraries.Prelude.instance"

---@param metaclass Metaclass
local Class = function(metaclass)
    ---@param initial Initial?
    return function(initial)
        if metaclass.initializer ~= nil then
            metaclass.initializer(initial, metaclass.attributes)
        end

        return Instance(metaclass)
    end
end

return Class
