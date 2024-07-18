local Background = require "Libraries.Engine.Widgets.background"
local Blizzard = require "Sources.Widgets.blizzard"
local Count = require "Sources.Widgets.count"
local Counter = require "Sources.Widgets.counter"
local Pause = require "Sources.Widgets.pause"
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
