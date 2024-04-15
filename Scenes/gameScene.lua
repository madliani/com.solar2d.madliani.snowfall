local audio = require("audio")
local composer = require("composer")
local display = require("display")
local timer = require("timer")

local scene = composer.newScene()

local backgroundImage = display.newImageRect("Assets/background.png", display.pixelWidth, display.pixelHeight)

local backgroundSound = audio.loadSound("Sounds/The field of dreams.mp3")
local volume = nil

local snowflakes = {}

local function createSnowflake(sceneGroup)
	local snowflake = display.newImageRect("Assets/snowflake.png", 36, 36)

	snowflake.x = math.random(display.contentWidth)
	snowflake.y = -snowflake.contentHeight

	sceneGroup:insert(snowflake)
	table.insert(snowflakes, snowflake)
end

local function updateSnowflakes()
	for i = #snowflakes, 1, -1 do
		local snowflake = snowflakes[i]

		snowflake.y = snowflake.y + 1

		if snowflake.y > display.contentHeight then
			display.remove(snowflake)
			table.remove(snowflakes, i)
		end
	end
end

local function createSnowflakes(sceneGroup)
	createSnowflake(sceneGroup)

	timer.performWithDelay(500, function ()
		createSnowflakes(sceneGroup)
	end)
end

function scene:create()
	local sceneGroup = self.view

	backgroundImage.x = display.contentCenterX
	backgroundImage.y = display.contnetCenterY
	sceneGroup:insert(backgroundImage)

	createSnowflakes(sceneGroup)

	audio.play(backgroundSound)
	volume = audio.getVolume()
end

function scene:show()
	backgroundImage.isVisible = true

	audio.setVolume(volume)
end

function scene:hide()
	backgroundImage.isVisible = false

	audio.setVolume(0)
end

function scene:destroy()
	backgroundImage:removeSelf()
	backgroundImage = nil

	audio.setVolume(0)
	backgroundSound = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

Runtime:addEventListener("enterFrame", updateSnowflakes)

return scene
