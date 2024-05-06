local Resources = require "resources"

local Background = require "Libraries.Engine.background"
local Scene = require "Libraries.Engine.scene"

local Blizzard = require "Sources.Objects.blizzard"
local Count = require "Sources.Objects.count"
local Counter = require "Sources.Objects.counter"

local background = Background(Resources.Images.background)

local count = Count(0)
local counter = Counter(count)
local blizzard = Blizzard(counter)

return Scene {
    background,
    count,
    blizzard,
}
