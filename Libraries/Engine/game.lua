local composer = require("composer")
local os = require("os")

local Resources = require("resources")

local Sound = require("Libraries.Engine.sound")

local Game = (function ()
    ---@type "startMenu" | "world" | nil
    local sceneName = nil

    ---@type table | nil
    local sound = Sound()

    local function destroy()
        if sceneName == "startMenu" and sound ~= nil then
            sound.destroy()

            sceneName = nil
            sound = nil

            os.exit()
        end
    end

    local function create()
        if sceneName == nil and sound ~= nil then
            sound.create(Resources.Sounds.background)
            composer.gotoScene("Sources.Scenes.startMenu")

            sceneName = "startMenu"
        end
    end

    local function resume()
        if sceneName == "startMenu" then
            composer.removeScene("Sources.Scenes.startMenu")
            composer.gotoScene("Sources.Scenes.world")

            sceneName = "world"
        end
    end

    return function ()
        ---@class Game
        ---@field create function
        ---@field destroy function
        ---@field resume function
        return {
            create = create,
            destroy = destroy,
            resume = resume
        }
    end
end)()

return Game
