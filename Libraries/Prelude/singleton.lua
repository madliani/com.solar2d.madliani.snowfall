local Instance = require "Libraries.Prelude.instance"

---@param metaclass Metaclass
local Singleton = function(metaclass)
    ---@type Instance | nil
    local instance = nil

    ---@param initial Initial?
    return function(initial)
        if instance == nil then
            if initial ~= nil then
                metaclass.initializer(initial, metaclass.attributes)
            end

            instance = Instance(metaclass)
        end

        return instance
    end
end

return Singleton
