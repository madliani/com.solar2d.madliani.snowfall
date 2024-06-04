local Resources = require "resources"
local Snowflake = require "Sources.Objects.snowflake"
local timer = require "timer"

---@param counter Counter
local Blizzard = function(counter)
    ---@type unknown[]
    local snowflakes = {}

    ---@type table | nil
    local generationLoop = nil

    ---@type table | nil
    local sceneGroup = nil

    local function generate()
        if sceneGroup ~= nil then
            local snowflake = Snowflake(Resources.Images.snowflake, counter)

            snowflake.create(sceneGroup)
            table.insert(snowflakes, snowflake)
        end
    end

    local function update()
        if #snowflakes > 0 then
            for i = #snowflakes, 1, -1 do
                local snowflake = snowflakes[i]

                if snowflake.isUnavable() then
                    snowflake.destroy()
                else
                    snowflake.update()
                end
            end
        end
    end

    local function destroy()
        Runtime.removeEventListener(Runtime, "enterFrame", update)

        if generationLoop ~= nil then
            timer.cancel(generationLoop)

            generationLoop = nil
        end

        if #snowflakes > 0 and sceneGroup ~= nil then
            for i = 1, #snowflakes, 1 do
                local snowflake = snowflakes[i]

                snowflake.destroy()
            end

            sceneGroup = nil
        end
    end

    ---@param group table
    local function create(group)
        sceneGroup = group

        generationLoop = timer.performWithDelay(500, generate, 0)

        Runtime.addEventListener(Runtime, "enterFrame", update)
    end

    local function show()
        if #snowflakes > 0 then
            for i = 1, #snowflakes, 1 do
                local snowflake = snowflakes[i]

                snowflake.show()
            end
        end
    end

    local function pause()
        timer.pause(generationLoop)
        Runtime.removeEventListener(Runtime, "enterFrame", update)
    end

    local function resume()
        timer.resume(generationLoop)
        Runtime.addEventListener(Runtime, "enterFrame", update)
    end

    local function hide()
        if #snowflakes > 0 then
            for i = 1, #snowflakes, 1 do
                local snowflake = snowflakes[i]

                snowflake.hide()
            end
        end
    end

    ---@class Blizzard
    ---@field pause function
    ---@field resume function
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field show function
    return {
        pause = pause,
        resume = resume,
        create = create,
        destroy = destroy,
        hide = hide,
        show = show,
    }
end

return Blizzard
