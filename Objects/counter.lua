---@param count table
local Counter = function (count)
    local function inc()
        count.inc()
    end

    local function dec()
        count.dec()
    end

    ---@class Counter
    ---@field dec function
    ---@field inc function
    return {
        dec = dec,
        inc = inc
    }
end

return Counter
