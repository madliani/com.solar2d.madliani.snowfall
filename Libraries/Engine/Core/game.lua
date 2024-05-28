local SceneManager = require "Libraries.Engine.Core.sceneManager"
local Sound = require "Libraries.Engine.Core.sound"
local os = require "os"

---@class GameClassInitial
---@field scenePaths ScenePaths
---@field soundPath string

---@class Game
---@field exit fun()
---@field run fun()
---@field start fun()

---@alias GameClass fun(initial: GameClassInitial): Game

---@alias GameIdentificator string

---@class GameAttributes
---@field scenePaths ScenePaths | nil
---@field soundPath string | nil

---@class GameSelf
---@field scenePaths ScenePaths | nil
---@field soundPath string | nil
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

---@alias GameSingleton fun(metaclass: GameMetaclass): GameClass

---@type GameSingleton
local Singleton = require "Libraries.Prelude.singleton"

local sceneManager = SceneManager()
local sound = Sound()

local Game = Singleton {
    id = "game",

    attributes = {
        scenePaths = nil,
        soundPath = nil,
    },

    methods = {
        exit = function(self)
            if self.soundPath ~= nil and self.scenePaths ~= nil then
                sceneManager.finalize()
                sound.finalize()

                self.soundPath = nil
                self.scenePaths = nil

                os.exit()
            end
        end,

        run = function(self)
            if self.soundPath ~= nil and self.scenePaths ~= nil then
                sound.initialize(self.soundPath)
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
