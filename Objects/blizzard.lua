local timer = require("timer")

local Snowflake = require("Objects.snowflake")

local Blizzard = function ()
    local snowflakes = {}
    local sceneGroup = nil

    ---@param group table
    local function addSceneGroup(group)
        sceneGroup = group
    end

    local function create()
        if sceneGroup ~= nil then
            local snowflake = Snowflake("Assets/snowflake.png")

            snowflake.addSceneGroup(sceneGroup)
            snowflake.create()
            table.insert(snowflakes, snowflake)

            timer.performWithDelay(500, create)
        end
    end

    local function show()
        if #snowflakes ~= 0 then
            for i = 1, #snowflakes, 1 do
                snowflakes[i].show()
            end
        end
    end

    local function hide()
        if #snowflakes ~= 0 then
            for i = 1, #snowflakes, 1 do
                snowflakes[i].hide()
            end
        end
    end

    local function destroy()
        if #snowflakes ~= 0 and sceneGroup ~= nil then
            for i = 1, #snowflakes, 1 do
                local snowflake = snowflakes[i]

                sceneGroup:remove(snowflake)
                snowflake.destroy()
                table.remove(snowflakes, i)
            end

            snowflakes = nil
        end
    end

    local function update()
        if #snowflakes ~= 0 then
            for i = #snowflakes, 1, -1 do
                local snowflake = snowflakes[i]

                snowflake.incY()

                if snowflake.isRemovable() then
                    snowflake.destroy()
                    table.remove(snowflakes, i)
                end
            end
        end
    end

    ---@class Blizzard
    ---@field addSceneGroup function
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field show function
    ---@field update function
    return {
        addSceneGroup = addSceneGroup,
        create = create,
        destroy = destroy,
        hide = hide,
        show = show,
        update = update
    }
end

return Blizzard
