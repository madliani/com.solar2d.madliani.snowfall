local Game = require "Libraries.Engine.Core.game"
local Composer = require "Libraries.Engine.Core.composer"
local Sound = require "Libraries.Engine.Core.sound"

local sound = Sound()

local Snowfall = Game {
    composer = Composer {
        start = "Sources.Scenes.startMenu",
        world = "Sources.Scenes.world",
    },
    sound = sound,
}

return Snowfall
