local composer = require("composer")
local display = require("display")

local scene = composer.newScene()
local background = display.newImageRect("Assets/background.png", display.pixelWidth, display.pixelHeight)

function scene:create()
    local sceneGroup = self.view

    background.x = display.contentCenterX
    background.y = display.contnetCenterY

    sceneGroup:insert(background)
end

function scene:show()
    background.isVisible = true
end

function scene:hide()
    background.isVisible = false
end

function scene:destroy()
    background:removeSelf()

    background = nil
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
