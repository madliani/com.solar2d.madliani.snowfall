local _ = require "Libraries.Prelude.enumerable"

---@alias Instance table<Method>

---@param class Class
---@param initial InitialAttributes?
local Instance = function(class, initial)
    local attributes = class.attributes

    if initial ~= nil then
        attributes = _.merge(class.attributes, initial)
    end

    ---@type Instance
    return _.map(class.methods, function(method)
        return function(args)
            method(attributes, args)
        end
    end)
end

return Instance
