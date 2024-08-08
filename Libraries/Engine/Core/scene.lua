local Pool = require "Libraries.Engine.Core.pool"
local composer = require "composer"

---@class Scene

---@alias SceneObjects any[]
---@alias SceneClass fun(): SceneManager
---@alias SceneIdentificator string

---@class ScenePrototype
---@field id SceneIdentificator
---@field wrapper fun(objects: SceneObjects): Scene

---@alias SceneAdapter fun(prototype: ScenePrototype): SceneClass

local Adapter = require "Libraries.Prelude.adapter"

local Scene = Adapter {
    id = "scene",

    wrapper = function(objects)
        local pool = Pool(objects)
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

        return scene
    end,
}

return Scene
