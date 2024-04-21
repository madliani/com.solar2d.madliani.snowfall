local Scene = require("Lib.Engine.scene")
local Background = require("Lib.Engine.background")
local BackgroundSound = require("Lib.Engine.backgroundSound")

local Count = require("Objects.count")
local Counter = require("Objects.counter")
local Blizzard = require("Objects.blizzard")

local background = Background("Assets/background.png")
local backgroundSound = BackgroundSound("Sounds/the_field_of_dreams.mp3")

local count = Count(0)
local counter = Counter(count)
local blizzard = Blizzard(counter)

return Scene {
    background = background,
    sound = backgroundSound,
    objects = {
        blizzard
    }
}
