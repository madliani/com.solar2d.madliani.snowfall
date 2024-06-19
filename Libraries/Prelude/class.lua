local Instance = require "Libraries.Prelude.instance"

---@param metaclass Metaclass
local Class = function(metaclass)
    return function(...)
        if metaclass.initializer ~= nil then
            metaclass.initializer(..., metaclass.attributes)
        end

        return Instance(metaclass)
    end
end

return Class
