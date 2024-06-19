local Instance = require "Libraries.Prelude.instance"

---@param metaclass Metaclass
local Singleton = function(metaclass)
    ---@type Instance | nil
    local instance = nil

    return function(...)
        if instance == nil then
            if metaclass.initializer ~= nil then
                metaclass.initializer(..., metaclass.attributes)
            end

            instance = Instance(metaclass)
        end

        return instance
    end
end

return Singleton
