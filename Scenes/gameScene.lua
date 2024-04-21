local composer = require("composer")

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

pool.insert(backgroundImage)
pool.insert(backgroundSound)

pool.insert(count)
pool.insert(blizzard)

local scene = composer.newScene()

function scene.create(self)
	local sceneGroup = self.view

	pool.create(sceneGroup)
end

function scene.show()
	pool.show()
end

function scene.hide()
	pool.hide()
end

function scene.destroy()
	pool.destroy()
end

scene.addEventListener(scene, "create")
scene.addEventListener(scene, "show")
scene.addEventListener(scene, "hide")
scene.addEventListener(scene, "destroy")

return scene
