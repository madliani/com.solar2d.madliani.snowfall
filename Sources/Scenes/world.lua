local Resources = require("resources")

local Scene = require("Libraries.Engine.scene")
local Background = require("Libraries.Engine.background")

local Count = require("Sources.Objects.count")
local Counter = require("Sources.Objects.counter")
local Blizzard = require("Sources.Objects.blizzard")

local background = Background(Resources.Images.background)

local count = Count(0)
local counter = Counter(count)
local blizzard = Blizzard(counter)

return Scene {
    background = background,
    objects = {
        count,
        blizzard
    }
}
