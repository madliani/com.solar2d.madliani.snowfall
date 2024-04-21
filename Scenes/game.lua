local Scene = require("Lib.Engine.scene")
local BackgroundImage = require("Lib.Engine.backgroundImage")
local BackgroundSound = require("Lib.Engine.backgroundSound")

local Count = require("Objects.count")
local Counter = require("Objects.counter")
local Blizzard = require("Objects.blizzard")

local backgroundImage = BackgroundImage("Assets/background.png")
local backgroundSound = BackgroundSound("Sounds/the_field_of_dreams.mp3")

local count = Count(0)
local counter = Counter(count)
local blizzard = Blizzard(counter)

return Scene {
    background = backgroundImage,
    sound = backgroundSound,
    objects = {
        blizzard
    }
}
