local Game = require "Libraries.Engine.Core.game"
local Scenes = require "Libraries.Engine.Core.scenes"
local Sound = require "Libraries.Engine.Core.sound"

local sound = Sound()

local Snowfall = Game {
    scenes = Scenes {
        start = "Sources.Scenes.startMenu",
        world = "Sources.Scenes.world",
    },
    sound = sound,
}

return Snowfall
