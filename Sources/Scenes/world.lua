local Background = require "Libraries.Engine.Nodes.background"
local Blizzard = require "Sources.Nodes.blizzard"
local Count = require "Sources.Nodes.count"
local Counter = require "Sources.Middleware.counter"
local Pause = require "Sources.Nodes.pause"
local Resources = require "resources"
local Scene = require "Libraries.Engine.Core.scene"

local background = Background(Resources.Images.background)
local count = Count(0)
local counter = Counter(count)
local pause = Pause()
local blizzard = Blizzard(counter)

return Scene {
    background,
    count,
    pause,
    blizzard,
}
