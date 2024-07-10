local Object = require "Libraries.Prelude.object"

---@param metaclass Metaclass
local Singleton = function(metaclass)
    ---@type Object | nil
    local object = nil

    return function(...)
        if object == nil then
            if metaclass.initializer ~= nil then
                metaclass.initializer(..., metaclass.attributes)
            end

            object = Object(metaclass)
        end

        return object
    end
end

return Singleton
