local composer = require("composer")
local display = require("display")
local timer = require("timer")

local BackgroundImage = require("Objects.backgroundImage")
local BackgroundSound = require("Objects.backgroundSound")

local scene = composer.newScene()

local backgroundImage = BackgroundImage("Assets/background.png")

local backgroundSound = BackgroundSound("Sounds/the_field_of_dreams.mp3")

local snowflakes = {}

local function createSnowflake(sceneGroup)
	local scale = math.random(5, 15)
	local snowflakeWidth = display.pixelWidth / display.contentWidth * scale
	local snowflakeHeight = display.pixelWidth / display.contentWidth * scale
	local snowflake = display.newImageRect("Assets/snowflake.png", snowflakeWidth, snowflakeHeight)

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

function scene.create(self)
	local sceneGroup = self.view

	backgroundImage.create(sceneGroup)

	createSnowflakes(sceneGroup)

	backgroundSound.create()
end

function scene.show()
	backgroundImage.show()

	backgroundSound.unmute()
end

function scene:hide()
	backgroundImage.hide()

	backgroundSound.mute()
end

function scene.destroy()
	backgroundImage.destroy()
	backgroundImage = nil

	backgroundSound.destroy()
	backgroundSound = nil
end

scene:addEventListener("create")
scene:addEventListener("show")
scene:addEventListener("hide")
scene:addEventListener("destroy")

Runtime:addEventListener("enterFrame", updateSnowflakes)

return scene
