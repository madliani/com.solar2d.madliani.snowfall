local Instance = require "Libraries.Prelude.instance"

---@param class Metaclass
local Singleton = function(class)
    ---@type Instance | nil
    local instance = nil

    ---@param initial Initial?
    return function(initial)
        if instance == nil then
            instance = Instance(class, initial)
        end

        return instance
    end
end

return Singleton
