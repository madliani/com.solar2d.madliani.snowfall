local composer = require "composer"

---@alias Effect string

---@class SceneManager
---@field gotoScene fun(scene: ScenePath, effect: Effect, time: Time)
---@field removeScene fun(scene: ScenePath)

---@alias ScenePath string

---@alias SceneManagerClass fun(): SceneManager
---@alias SceneManagerIdentificator string

---@class SceneManagerAttributes

---@class SceneManagerSelf: SceneManagerAttributes, SceneManagerMethods

---@class SceneManagerMethods
---@field gotoScene fun(self: SceneManagerSelf, scene: ScenePath, effect: Effect, time: Time)
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
        gotoScene = function(_, scene, effect, time)
            local options = { effect = effect, time = time }

            composer.gotoScene(scene, options)
        end,

        removeScene = function(_, scene)
            composer.removeScene(scene)
        end,
    },
}

return SceneManager
