local Resources = require "resources"
local SceneManager = require "Libraries.Engine.Core.sceneManager"
local os = require "os"

---@alias GameIdentificator string

---@class GameAttributes
---@field scenePaths ScenePaths | nil
---@field sound Sound | nil

---@class GameSelf
---@field scenePaths ScenePaths | nil
---@field sound Sound | nil
---@field exit fun(self: GameSelf)
---@field run fun(self: GameSelf)
---@field start fun(self: GameSelf)

---@class GameMethods
---@field exit fun(self: GameSelf)
---@field run fun(self: GameSelf)
---@field start fun(self: GameSelf)

---@class GameMetaclass
---@field id GameIdentificator
---@field attributes GameAttributes
---@field methods GameMethods

---@class GameClassArguments
---@field scenePaths ScenePaths
---@field sound Sound

---@class Game
---@field exit fun()
---@field run fun()
---@field start fun()

---@alias GameClass fun(arguments: GameClassArguments): Game

---@alias GameSingleton fun(metaclass: GameMetaclass): GameClass

---@type GameSingleton
local Singleton = require "Libraries.Prelude.singleton"

local sceneManager = SceneManager()

local Game = Singleton {
    id = "Game",
    attributes = {
        scenePaths = nil,
        sound = nil,
    },
    methods = {
        exit = function(self)
            if self.sound ~= nil and self.scenePaths ~= nil then
                self.sound.finalize()

                sceneManager.finalize()

                self.sound = nil
                self.scenePaths = nil

                os.exit()
            end
        end,
        run = function(self)
            if self.sound ~= nil and self.scenePaths ~= nil then
                self.sound.initialize(Resources.Sounds.background)

                sceneManager.initialize(self.scenePaths)

                sceneManager.gotoStart()
            end
        end,
        start = function()
            sceneManager.gotoWorld()
        end,
    },
}

return Game
