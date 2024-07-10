local _ = require "Libraries.Prelude.enumerable"

---@alias Object table<Function>

---@param metaclass Metaclass
local Object = function(metaclass)
    local self = _.merge(metaclass.attributes, metaclass.methods)

    ---@type Object
    return _.map(metaclass.methods, function(method)
        return function(...)
            method(self, ...)
        end
    end)
end

return Object
