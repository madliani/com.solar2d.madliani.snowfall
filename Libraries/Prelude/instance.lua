local _ = require "Libraries.Prelude.enumerable"

---@alias Instance table<Function>

---@param metaclass Metaclass
local Instance = function(metaclass)
    local self = _.merge(metaclass.attributes, metaclass.methods)

    ---@type Instance
    return _.map(metaclass.methods, function(method)
        return function(...)
            method(self, ...)
        end
    end)
end

return Instance
