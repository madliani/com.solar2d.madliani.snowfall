---@param prototype ContainerPrototype
local ContainerPrototype = function(prototype)
    return function(...)
        return prototype.maker(...)
    end
end

return ContainerPrototype
