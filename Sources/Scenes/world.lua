local Background = require "Libraries.Engine.Nodes.background"
local Blizzard = require "Sources.Nodes.blizzard"
local Pause = require "Sources.Nodes.pause"
local Resources = require "resources"
local Scene = require "Libraries.Engine.Core.scene"
local Score = require "Sources.Nodes.score"
local ScoreCounter = require "Sources.Middleware.scoreCounter"
local Time = require "Sources.Nodes.time"
local TimeCounter = require "Sources.Middleware.timeCounter"

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
