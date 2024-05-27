local _ = require "Libraries.Prelude.enumerable"

---@alias Instance table<Function>
---@alias InitialArguments Arguments

---@param metaclass Metaclass
---@param initial InitialArguments?
local Instance = function(metaclass, initial)
    local self = _.merge(metaclass.attributes, metaclass.methods)

    if initial ~= nil then
        self = _.merge(metaclass.attributes, initial)
    end

    ---@type Instance
    return _.map(metaclass.methods, function(method)
        return function(arguments)
            method(self, arguments)
        end
    end)
end

return Instance
