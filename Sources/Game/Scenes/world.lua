local Background = require "Libraries.Engine.Nodes.background"
local Blizzard = require "Sources.Game.Nodes.blizzard"
local Pause = require "Sources.Game.Nodes.pause"
local Resources = require "Sources.Game.resources"
local Scene = require "Libraries.Engine.Core.scene"
local Score = require "Sources.Game.Nodes.score"
local ScoreCounter = require "Sources.Game.Middleware.scoreCounter"
local Time = require "Sources.Game.Nodes.time"
local TimeCounter = require "Sources.Game.Middleware.timeCounter"

local background = Background(Resources.Images.background)
local score = Score(0)
local scoreCounter = ScoreCounter(score)
local time = Time(18000)
local timeCounter = TimeCounter(time, 18000)
local pause = Pause()
local blizzard = Blizzard(scoreCounter)

timeCounter.start()

return Scene {
    background,
    score,
    time,
    pause,
    blizzard,
}
