local LoopManager = require "Libraries.Engine.Core.loopManager"
local Music = require "Libraries.Engine.Core.music"
local SceneManager = require "Libraries.Engine.Core.sceneManager"
local os = require "os"

---@class GameInitial
---@field scenePaths ScenePaths
---@field musicPath MusicPath

---@class Game
---@field exit fun()
---@field run fun()
---@field start fun()

---@alias GameClass fun(initial: GameInitial): Game
---@alias GameIdentificator string

---@class GameAttributes
---@field sceneManager SceneManager | nil
---@field music Music | nil

---@class GameSelf
---@field sceneManager SceneManager
---@field music Music
---@field exit fun(self: GameSelf)
---@field pause fun(self: GameSelf)
---@field resume fun(self: GameSelf)
---@field run fun(self: GameSelf)
---@field start fun(self: GameSelf)

---@class GameMethods
---@field exit fun(self: GameSelf)
---@field pause fun()
---@field resume fun()
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

local loopManager = LoopManager()

local Game = Singleton {
    id = "game",

    attributes = {
        iteratee = nil,
        sceneManager = nil,
        music = nil,
    },

    methods = {
        exit = function()
            os.exit()
        end,

        pause = function()
            loopManager.pauseAll()
        end,

        resume = function()
            loopManager.resumeAll()
        end,

        run = function(self)
            self.sceneManager.gotoStart()
        end,

        start = function(self)
            self.sceneManager.gotoWorld()
        end,
    },

    initializer = function(initial, attributes)
        if attributes.sceneManager == nil and attributes.music == nil then
            attributes.sceneManager = SceneManager(initial.scenePaths)
            attributes.music = Music(initial.musicPath)
        end
    end,

    finalizer = function(attributes)
        if attributes.sceneManager ~= nil and attributes.music ~= nil then
            attributes.sceneManager = nil
            attributes.music = nil
        end
    end,
}

return Game
