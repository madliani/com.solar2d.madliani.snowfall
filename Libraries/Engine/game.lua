local composer = require("composer")
local os = require("os")

local Resources = require("resources")

local Sound = require("Libraries.Engine.sound")

local Game = (function ()
    local startScene = nil
    local worldScene = nil

    ---@type table | nil
    local sound = Sound()

    local function exit()
        if sound ~= nil then
            sound.destroy()

            startScene = nil
            worldScene = nil
            sound = nil

            os.exit()
        end
    end

    local function start()
        if sound ~= nil and startScene ~= nil then
            sound.create(Resources.Sounds.background)
            composer.gotoScene(startScene)
        end
    end

    local function run()
       if startScene ~= nil and worldScene ~= nil then
            composer.removeScene(startScene)
            composer.gotoScene(worldScene)
       end
    end

    ---@param scenes table
    return function (scenes)
        startScene = scenes.start
        worldScene = scenes.world

        ---@class Game
        ---@field exit function
        ---@field run function
        ---@field start function
        return {
            exit = exit,
            run = run,
            start = start
        }
    end
end)()

return Game
