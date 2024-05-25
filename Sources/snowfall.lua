local Game = require "Libraries.Engine.Core.game"
local SceneManager = require "Libraries.Engine.Core.sceneManager"
local Sound = require "Libraries.Engine.Core.sound"

local sound = Sound()

local Snowfall = Game {
    sceneManager = SceneManager {
        start = "Sources.Scenes.startMenu",
        world = "Sources.Scenes.world",
    },
    sound = sound,
}

return Snowfall
