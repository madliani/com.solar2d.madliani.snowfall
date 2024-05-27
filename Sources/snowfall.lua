local Game = require "Libraries.Engine.Core.game"
local Sound = require "Libraries.Engine.Core.sound"

local sound = Sound()

local Snowfall = Game {
    scenePaths = {
        start = "Sources.Scenes.startMenu",
        world = "Sources.Scenes.world",
    },
    sound = sound,
}

return Snowfall
