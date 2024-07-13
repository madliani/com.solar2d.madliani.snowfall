local _ = require "Libraries.Prelude.enumerable"

---@alias ObjectFieldId FieldId
---@alias Object table<ObjectFieldId, Function>

---@param prototype Prototype
local Object = function(prototype)
    local self = _.merge(prototype.attributes, prototype.methods)

    ---@type Object
    return _.map(prototype.methods, function(method)
        return function(...)
            method(self, ...)
        end
    end)
end

return Object
