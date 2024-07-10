local Object = require "Libraries.Prelude.object"

---@param prototype Prototype
local Metaclass = function(prototype)
    return function(...)
        if prototype.initializer ~= nil then
            prototype.initializer(prototype.attributes, ...)
        end

        return Object(prototype)
    end
end

return Metaclass
