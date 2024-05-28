local Game = require "Libraries.Engine.Core.game"
local Resources = require "resources"

local Snowfall = Game {
    scenePaths = {
        start = "Sources.Scenes.startMenu",
        world = "Sources.Scenes.world",
    },
    soundPath = Resources.Sounds.background,
}

return Snowfall
