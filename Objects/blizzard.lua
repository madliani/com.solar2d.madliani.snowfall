local timer = require("timer")

local Snowflake = require("Objects.snowflake")

---@param counter table
local Blizzard = function (counter)
    local snowflakes = {}
    local sceneGroup = nil

    ---@param group table
    local function insertSceneGroup(group)
        sceneGroup = group
    end

    local function generateSnowflakes()
        if snowflakes ~= nil and sceneGroup ~= nil then
            local snowflake = Snowflake("Assets/snowflake.png", counter)

            snowflake.insertSceneGroup(sceneGroup)
            snowflake.create()
            table.insert(snowflakes, snowflake)

            timer.performWithDelay(500, generateSnowflakes)
        end
    end

    local function update()
        if snowflakes ~= nil and #snowflakes ~= 0 then
            for i = #snowflakes, 1, -1 do
                local snowflake = snowflakes[i]

                if snowflake.isUnavable() then
                    table.remove(snowflakes, i)
                else
                    snowflake.update()
                end
            end
        end
    end

    local function destroy()
        if snowflakes ~= nil and #snowflakes ~= 0 and sceneGroup ~= nil then
            for i = 1, #snowflakes, 1 do
                local snowflake = snowflakes[i]

                snowflake.destroy()
                table.remove(snowflakes, i)
            end

            snowflakes = nil
        end
    end

    local function create()
        generateSnowflakes()

        Runtime.addEventListener(Runtime, "enterFrame", update)
    end

    local function show()
        if snowflakes ~= nil and #snowflakes ~= 0 then
            for i = 1, #snowflakes, 1 do
                snowflakes[i].show()
            end
        end
    end

    local function hide()
        if snowflakes ~= nil and #snowflakes ~= 0 then
            for i = 1, #snowflakes, 1 do
                snowflakes[i].hide()
            end
        end
    end

    ---@class Blizzard
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field insertSceneGroup function
    ---@field show function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        insertSceneGroup = insertSceneGroup,
        show = show,
    }
end

return Blizzard
