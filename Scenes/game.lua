local resources = require("resources")

local Scene = require("Lib.Engine.scene")
local Background = require("Lib.Engine.background")
local Sound = require("Lib.Engine.sound")

local Count = require("Objects.count")
local Counter = require("Objects.counter")
local Blizzard = require("Objects.blizzard")

local background = Background(resources.images.background)
local sound = Sound(resources.sounds.gameSound)

local count = Count(0)
local counter = Counter(count)
local blizzard = Blizzard(counter)

return Scene {
    background = background,
    sound = sound,
    objects = {
        count,
        blizzard
    }
}
