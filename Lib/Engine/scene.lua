local composer = require("composer")

local Pool = require("Lib.Engine.pool")

---@param objects table
local Scene = function (objects)
    local background = objects.background
    local sound = objects.sound

    local pool = Pool(objects.objects)

    local scene = composer.newScene()

    function scene.destroy()
        background.destroy()
        sound.destroy()

        pool.destroy()
    end

    function scene.create(self)
        local sceneGroup = self.view

        background.create(sceneGroup)
        sound.create(sceneGroup)

        pool.create(sceneGroup)
    end

    function scene.show()
        background.show()
        sound.show()

        pool.show()
    end

    function scene.hide()
        background.hide()
        sound.hide()

        pool.hide()
    end

    scene.addEventListener(scene, "destroy")
    scene.addEventListener(scene, "create")
    scene.addEventListener(scene, "show")
    scene.addEventListener(scene, "hide")

    ---@class Scene
    return scene
end

return Scene
