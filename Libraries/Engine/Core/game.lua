local SceneManager = require "Libraries.Engine.Core.sceneManager"
local Sound = require "Libraries.Engine.Core.sound"
local os = require "os"

---@class GameInitial
---@field scenePaths ScenePaths
---@field soundPath string

---@class Game
---@field exit fun()
---@field run fun()
---@field start fun()

---@alias GameClass fun(initial: GameInitial): Game
---@alias GameIdentificator string

---@class GameAttributes
---@field sceneManager SceneManager | nil
---@field sound Sound | nil

---@class GameSelf
---@field sceneManager SceneManager
---@field sound Sound
---@field exit fun(self: GameSelf)
---@field run fun(self: GameSelf)
---@field start fun(self: GameSelf)

---@class GameMethods
---@field exit fun(self: GameSelf)
---@field run fun(self: GameSelf)
---@field start fun(self: GameSelf)

---@alias GameInitializer fun(initial: GameInitial, attributes: GameAttributes)
---@alias GameFinalizer fun(attributes: GameAttributes)

---@class GameMetaclass
---@field id GameIdentificator
---@field attributes GameAttributes
---@field initializer GameInitializer
---@field finalizer GameFinalizer
---@field methods GameMethods

---@alias GameSingleton fun(metaclass: GameMetaclass): GameClass

---@type GameSingleton
local Singleton = require "Libraries.Prelude.singleton"

local Game = Singleton {
    id = "game",

    attributes = {
        iteratee = nil,
        sceneManager = nil,
        sound = nil,
    },

    methods = {
        exit = function(self)
            os.exit()
        end,

        run = function(self)
            self.sceneManager.gotoStart()
        end,

        start = function(self)
            self.sceneManager.gotoWorld()
        end,
    },

    initializer = function(initial, attributes)
        if attributes.sceneManager == nil and attributes.sound == nil then
            attributes.sceneManager = SceneManager(initial.scenePaths)
            attributes.sound = Sound(initial.soundPath)
        end
    end,

    finalizer = function(attributes)
        if attributes.sceneManager ~= nil and attributes.sound ~= nil then
            attributes.sceneManager = nil
            attributes.sound = nil
        end
    end,
}

return Game
