---@param score Score
local ScoreCounter = function(score)
    local function inc()
        score.inc()
    end

    local function dec()
        score.dec()
    end

    ---@class ScoreCounter
    ---@field dec function
    ---@field inc function
    return {
        dec = dec,
        inc = inc,
    }
end

return ScoreCounter
