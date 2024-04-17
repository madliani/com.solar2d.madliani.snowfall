local timer = require("timer")

local Snowflake = require("Objects.snowflake")

local Blizzard = function ()
    local snowflakes = {}
    local sceneGroup = nil

    ---@param group table
    local function create(group)
        sceneGroup = group

        if sceneGroup ~= nil then
            local snowflake = Snowflake("Assets/snowflake.png")

            snowflake.create(sceneGroup)
            table.insert(snowflakes, snowflake)

            timer.performWithDelay(500, function ()
                create(sceneGroup)
            end)
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
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field show function
    ---@field update function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        show = show,
        update = update
    }
end

return Blizzard
