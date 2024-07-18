local Event = require "Libraries.Engine.Core.event"
local Loop = require "Libraries.Engine.Core.loop"
local LoopManager = require "Libraries.Engine.Core.loopManager"
local Resources = require "resources"
local Snowflake = require "Sources.Widgets.snowflake"
local Task = require "Libraries.Engine.Core.task"

local loopManager = LoopManager()

---@param counter Counter
local Blizzard = function(counter)
    ---@type unknown[]
    local snowflakes = {}

    ---@type table | nil
    local sceneGroup = nil

    local function destroy()
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

        local task = Task(generate, 500)
        local event = Event(update, "enterFrame")
        local loop = Loop(task, event)

        loopManager.add(loop, "blizzard")
    end

    local function show()
        if #snowflakes > 0 then
            for i = 1, #snowflakes, 1 do
                local snowflake = snowflakes[i]

                snowflake.show()
            end
        end
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
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field show function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        show = show,
    }
end

return Blizzard
