local composer = require("composer")

local BackgroundImage = require("Objects.backgroundImage")
local BackgroundSound = require("Objects.backgroundSound")
local Blizzard = require("Objects.blizzard")

local scene = composer.newScene()

local backgroundImage = BackgroundImage("Assets/background.png")

local backgroundSound = BackgroundSound("Sounds/the_field_of_dreams.mp3")

local blizzard = Blizzard()

function scene.create(self)
	local sceneGroup = self.view

	backgroundImage.addSceneGroup(sceneGroup)
	backgroundImage.create()

	blizzard.addSceneGroup(sceneGroup)
	blizzard.create()

	backgroundSound.create()
end

function scene.show()
	backgroundImage.show()

	blizzard.show()

	backgroundSound.unmute()
end

function scene.hide()
	backgroundImage.hide()

	blizzard.hide()

	backgroundSound.mute()
end

function scene.destroy()
	backgroundImage.destroy()
	backgroundImage = nil

	backgroundSound.destroy()
	backgroundSound = nil

	blizzard.destroy()
	blizzard = nil
end

scene.addEventListener(scene, "create")
scene.addEventListener(scene, "show")
scene.addEventListener(scene, "hide")
scene.addEventListener(scene, "destroy")

return scene
