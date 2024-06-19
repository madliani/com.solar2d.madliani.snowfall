local composer = require "composer"

---@class SceneManager
---@field changeScene fun(scene: ScenePath)
---@field gotoPause fun()
---@field gotoStart fun()
---@field gotoWorld fun(needReplacement: boolean?)
---@field replaceScene fun(scene: ScenePath)

---@alias ScenePath string

---@class ScenePaths
---@field pause ScenePath
---@field start ScenePath
---@field world ScenePath

---@alias SceneManagerClass fun(paths: ScenePaths): SceneManager
---@alias SceneManagerIdentificator string

---@class SceneManagerAttributes
---@field scenes ScenePaths | nil
---@field activeScene ScenePath | nil

---@class SceneManagerSelf: SceneManagerAttributes, SceneManagerMethods

---@class SceneManagerMethods
---@field changeScene fun(self: SceneManagerSelf, scene: ScenePath)
---@field gotoPause fun(self: SceneManagerSelf, scene: ScenePath)
---@field gotoStart fun(self: SceneManagerSelf)
---@field gotoWorld fun(self: SceneManagerSelf, needReplacement: boolean?)
---@field replaceScene fun(self: SceneManagerSelf, scene: ScenePath)

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
        changeScene = function(self, scene)
            self.activeScene = scene

            composer.gotoScene(scene, { effect = "fade", time = 150 })
        end,

        replaceScene = function(self, scene)
            if self.activeScene ~= nil then
                composer.removeScene(self.activeScene)
            end

            self.changeScene(self, scene)
        end,

        gotoPause = function(self)
            if self.scenes ~= nil then
                self.changeScene(self, self.scenes.pause)
            end
        end,

        gotoStart = function(self)
            if self.scenes ~= nil then
                self.replaceScene(self, self.scenes.start)
            end
        end,

        gotoWorld = function(self, needReplecement)
            if self.scenes ~= nil then
                if needReplecement == true then
                    self.replaceScene(self, self.scenes.world)
                else
                    self.changeScene(self, self.scenes.world)
                end
            end
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
