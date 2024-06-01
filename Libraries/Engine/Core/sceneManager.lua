local composer = require "composer"

---@class SceneManager
---@field gotoScene fun(scene: ScenePath)
---@field gotoStart fun()
---@field gotoWorld fun()
---@field newScene fun()

---@alias ScenePath string

---@class ScenePaths
---@field start ScenePath
---@field world ScenePath

---@alias SceneManagerClass fun(paths: ScenePaths): SceneManager
---@alias SceneManagerIdentificator string

---@class SceneManagerAttributes
---@field scenes ScenePaths | nil
---@field activeScene ScenePath | nil

---@class SceneManagerSelf
---@field scenes ScenePaths
---@field activeScene ScenePath
---@field gotoScene fun(self: SceneManagerSelf, scene: ScenePath)
---@field gotoStart fun(self: SceneManagerSelf)
---@field gotoWorld fun(self: SceneManagerSelf)
---@field newScene fun(self: SceneManagerSelf)

---@class SceneManagerMethods
---@field gotoScene fun(self: SceneManagerSelf, scene: ScenePath)
---@field gotoStart fun(self: SceneManagerSelf)
---@field gotoWorld fun(self: SceneManagerSelf)
---@field newScene fun(self: SceneManagerSelf)

---@alias SceneManagerInitializer fun(paths: ScenePaths, attributes: SceneManagerAttributes)
---@alias SceneManagerFinalizer fun(attributes: SceneManagerAttributes)

---@class SceneManagerMetaclass
---@field id SceneManagerIdentificator
---@field attributes SceneManagerAttributes
---@field methods SceneManagerMethods
---@field initializer SceneManagerInitializer
---@field finalizer SceneManagerFinalizer

---@alias SceneManagerSingleton fun(metaclass: SceneManagerMetaclass): SceneManagerClass

---@type SceneManagerSingleton
local Singleton = require "Libraries.Prelude.singleton"

local SceneManager = Singleton {
    id = "scene_manager",

    attributes = {
        scenes = nil,
        activeScene = nil,
    },

    methods = {
        gotoScene = function(self, scene)
            if self.activeScene ~= nil then
                composer.removeScene(self.activeScene)
            end

            self.activeScene = scene

            composer.gotoScene(scene)
        end,

        gotoStart = function(self)
            if self.scenes ~= nil then
                self.gotoScene(self, self.scenes.start)
            end
        end,

        gotoWorld = function(self)
            if self.scenes ~= nil then
                self.gotoScene(self, self.scenes.world)
            end
        end,

        newScene = function()
            return composer.newScene()
        end,
    },

    initializer = function(paths, attributes)
        if attributes.scenes == nil then
            attributes.scenes = paths
        end
    end,

    finalizer = function(attributes)
        if attributes.activeScene ~= nil and attributes.scenes ~= nil then
            attributes.activeScene = nil

            attributes.scenes.start = nil
            attributes.scenes.world = nil

            attributes.scenes = nil
        end
    end,
}

return SceneManager
