local Scene = require("Lib.Engine.scene")
local Pool = require("Lib.Engine.pool")
local BackgroundImage = require("Lib.Engine.backgroundImage")
local BackgroundSound = require("Lib.Engine.backgroundSound")

local Count = require("Objects.count")
local Counter = require("Objects.counter")
local Blizzard = require("Objects.blizzard")

local pool = Pool()
local backgroundImage = BackgroundImage("Assets/background.png")
local backgroundSound = BackgroundSound("Sounds/the_field_of_dreams.mp3")

local count = Count(0)
local counter = Counter(count)
local blizzard = Blizzard(counter)

pool.insert({backgroundImage, backgroundSound, count, blizzard})

return Scene(pool)
