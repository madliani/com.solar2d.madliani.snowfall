local composer = require "composer"
local os = require "os"

local Resources = require "resources"

local Sound = require "Libraries.Engine.sound"

local Game = (function()
    ---@type string | nil
    local startScene = nil

    ---@type string | nil
    local worldScene = nil

    ---@type Sound | nil
    local sound = Sound()

    local function destroy()
        if sound ~= nil then
            sound.initialize()

            startScene = nil
            worldScene = nil
            sound = nil

            os.exit()
        end
    end

    local function create()
        if sound ~= nil and startScene ~= nil then
            sound.initialize(Resources.Sounds.background)
            composer.gotoScene(startScene)
        end
    end

    local function start()
        if startScene ~= nil and worldScene ~= nil then
            composer.removeScene(startScene)
            composer.gotoScene(worldScene)
        end
    end

    ---@param scenes table<any>
    return function(scenes)
        startScene = scenes.start
        worldScene = scenes.world

        ---@class Game
        ---@field exit function
        ---@field run function
        ---@field start function
        return {
            exit = destroy,
            run = create,
            start = start,
        }
    end
end)()

return Game
