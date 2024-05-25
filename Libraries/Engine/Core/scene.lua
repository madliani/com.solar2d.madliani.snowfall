local Pool = require "Libraries.Engine.Core.pool"
local composer = require "composer"

---@param objects unknown[]
local Scene = function(objects)
    local pool = Pool(objects)

    ---@type table
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
