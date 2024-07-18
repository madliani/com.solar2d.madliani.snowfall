local composer = require "composer"

---@class SceneManager
---@field gotoScene fun(scene: ScenePath)
---@field removeScene fun(scene: ScenePath)

---@alias ScenePath string

---@alias SceneManagerClass fun(): SceneManager
---@alias SceneManagerIdentificator string

---@class SceneManagerAttributes

---@class SceneManagerSelf: SceneManagerAttributes, SceneManagerMethods

---@class SceneManagerMethods
---@field gotoScene fun(self: SceneManagerSelf, scene: ScenePath)
---@field removeScene fun(self: SceneManagerSelf, scene: ScenePath)

---@class SceneManagerPrototype
---@field id SceneManagerIdentificator
---@field attributes SceneManagerAttributes
---@field methods SceneManagerMethods

---@alias SceneManagerSingleton fun(prototype: SceneManagerPrototype): SceneManagerClass

---@type SceneManagerSingleton
local Singleton = require "Libraries.Prelude.singleton"

local SceneManager = Singleton {
    id = "scene_manager",

    attributes = {},

    methods = {
        gotoScene = function(_, scene)
            composer.gotoScene(scene, { effect = "fade", time = 150 })
        end,

        removeScene = function(_, scene)
            composer.removeScene(scene)
        end,
    },
}

return SceneManager
