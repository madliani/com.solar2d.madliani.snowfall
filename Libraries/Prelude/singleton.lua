local Object = require "Libraries.Prelude.object"

---@param prototype SingletonPrototype
local Singleton = function(prototype)
    ---@type Object | nil
    local object = nil

    return function(...)
        if object == nil then
            if prototype.initializer ~= nil then
                prototype.initializer(..., prototype.attributes)
            end

            object = Object(prototype)
        end

        return object
    end
end

return Singleton
