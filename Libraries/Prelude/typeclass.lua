local Object = require "Libraries.Prelude.object"

---@param metaclass Metaclass
local Typeclass = function(metaclass)
    return function(...)
        if metaclass.initializer ~= nil then
            metaclass.initializer(metaclass.attributes, ...)
        end

        return Object(metaclass)
    end
end

return Typeclass
