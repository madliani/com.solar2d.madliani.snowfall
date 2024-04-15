local audio = require("audio")
local composer = require("composer")
local display = require("display")

local scene = composer.newScene()

local backgroundImage = display.newImageRect("Assets/background.png", display.pixelWidth, display.pixelHeight)

local backgroundSound = audio.loadSound("Sounds/The field of dreams.mp3")
local volume = nil

function scene:create()
    local sceneGroup = self.view

    backgroundImage.x = display.contentCenterX
    backgroundImage.y = display.contnetCenterY
    sceneGroup:insert(backgroundImage)

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

return scene
