---@param prototype Prototype
local Adapter = function(prototype)
    return function(...)
        return prototype.wrapper(...)
    end
end

return Adapter
