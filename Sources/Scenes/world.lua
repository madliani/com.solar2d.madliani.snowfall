local Background = require "Libraries.Engine.Widgets.background"
local Blizzard = require "Sources.Objects.blizzard"
local Count = require "Sources.Objects.count"
local Counter = require "Sources.Objects.counter"
local Pause = require "Sources.Objects.pause"
local Resources = require "resources"
local Scene = require "Libraries.Engine.Core.scene"

local background = Background(Resources.Images.background)
local count = Count(0)
local counter = Counter(count)
local blizzard = Blizzard(counter)
local pause = Pause()

return Scene {
    background,
    count,
    pause,
    blizzard
}
