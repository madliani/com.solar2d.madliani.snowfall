local composer = require "composer"

---@alias ScenePath string

---@class ScenePaths
---@field start ScenePath
---@field world ScenePath

---@class SceneManagerAttributes
---@field scenes ScenePaths | nil
---@field activeScene ScenePath | nil

---@class SceneManagerSelf
---@field scenes ScenePaths | nil
---@field activeScene ScenePath | nil
---@field initialize fun(self: SceneManagerSelf, paths: ScenePaths)
---@field finalize fun(self: SceneManagerSelf)
---@field gotoScene fun(self: SceneManagerSelf, scene: ScenePath)
---@field gotoStart fun(self: SceneManagerSelf)
---@field gotoWorld fun(self: SceneManagerSelf)
---@field newScene fun(self: SceneManagerSelf)

---@class SceneManagerMethods
---@field initialize fun(self: SceneManagerSelf, paths: ScenePaths)
---@field finalize fun(self: SceneManagerSelf)
---@field gotoScene fun(self: SceneManagerSelf, scene: ScenePath)
---@field gotoStart fun(self: SceneManagerSelf)
---@field gotoWorld fun(self: SceneManagerSelf)
---@field newScene fun(self: SceneManagerSelf)

---@class SceneManagerMetaclass
---@field attributes SceneManagerAttributes
---@field methods SceneManagerMethods

---@class SceneManager
---@field initialize fun(paths: ScenePaths)
---@field finalize fun()
---@field gotoScene fun(scene: ScenePath)
---@field gotoStart fun()
---@field gotoWorld fun()
---@field newScene fun()

---@alias SceneManagerSingleton fun(metaclass: SceneManagerMetaclass): SceneManager

---@type SceneManagerSingleton
local Singleton = require "Libraries.Prelude.singleton"

local SceneManager = Singleton {
    attributes = {
        scenes = nil,
        activeScene = nil,
    },

    methods = {
        initialize = function(self, paths)
            if self.scenes == nil then
                self.scenes = paths
            end
        end,

        finalize = function(self)
            self.activeScene = nil

            self.scenes.start = nil
            self.scenes.world = nil

            self.scenes = nil
        end,

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
}

return SceneManager
