local composer = require("composer")

---@param pool table
local Scene = function (pool)
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

    ---@class Scene
    return scene
end

return Scene
