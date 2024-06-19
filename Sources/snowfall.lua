local Game = require "Libraries.Engine.Core.game"
local Resources = require "resources"

local Snowfall = Game {
    scenePaths = {
        pause = "Sources.Scenes.pauseMenu",
        start = "Sources.Scenes.startMenu",
        world = "Sources.Scenes.world",
    },
    musicPath = Resources.Sounds.background,
}

return Snowfall
