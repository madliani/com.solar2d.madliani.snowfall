local composer = require("composer")

local Pool = require("Objects.pool")
local BackgroundImage = require("Objects.backgroundImage")
local BackgroundSound = require("Objects.backgroundSound")
local Blizzard = require("Objects.blizzard")

local scene = composer.newScene()

local pool = Pool()
local backgroundImage = BackgroundImage("Assets/background.png")
local blizzard = Blizzard()
local backgroundSound = BackgroundSound("Sounds/the_field_of_dreams.mp3")

pool.insert(backgroundImage)
pool.insert(blizzard)
pool.insert(backgroundSound)

function scene.create(self)
	local sceneGroup = self.view

	pool.addSceneGroup(sceneGroup)
	pool.create()
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
