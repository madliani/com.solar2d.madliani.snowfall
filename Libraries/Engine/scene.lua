local composer = require("composer")

local Pool = require("Libraries.Engine.pool")

---@param objects table
local Scene = function (objects)
    local background = objects.background

    local pool = Pool { background, Pool(objects.objects) }

    local scene = composer.newScene()

    function scene.destroy()
        pool.destroy()
    end

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

    scene.addEventListener(scene, "destroy")
    scene.addEventListener(scene, "create")
    scene.addEventListener(scene, "show")
    scene.addEventListener(scene, "hide")

    ---@class Scene
    return scene
end

return Scene
