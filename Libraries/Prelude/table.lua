---@alias TableClass fun(collection: table<unknown, any>): table<unknown, any>
---@alias Table fun(): TableClass

---@type Table
local Table = function ()
    return function (collection)
        return collection
    end
end

return Table
