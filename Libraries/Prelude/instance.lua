local _ = require "Libraries.Prelude.enumerable"

---@alias Instance table<Function>
---@alias InitialAttributes any[]

---@param metaclass Metaclass
---@param initial InitialAttributes?
local Instance = function(metaclass, initial)
    local attributes = metaclass.attributes

    if initial ~= nil then
        attributes = _.merge(metaclass.attributes, initial)
    end

    ---@type Instance
    return _.map(metaclass.methods, function(method)
        return function(arguments)
            method(attributes, arguments)
        end
    end)
end

return Instance
