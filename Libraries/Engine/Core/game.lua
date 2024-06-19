local LoopManager = require "Libraries.Engine.Core.loopManager"
local Music = require "Libraries.Engine.Core.music"
local SceneManager = require "Libraries.Engine.Core.sceneManager"
local os = require "os"

---@class GameInitial
---@field scenePaths ScenePaths
---@field musicPath MusicPath

---@class Game
---@field exit fun()
---@field pause fun()
---@field restart fun()
---@field resume fun()
---@field run fun()
---@field start fun()

---@alias GameClass fun(initial: GameInitial): Game
---@alias GameIdentificator string

---@class GameAttributes
---@field loopManager LoopManager | nil
---@field music Music | nil
---@field sceneManager SceneManager | nil

---@class GameSelf: GameAttributes, GameMethods

---@class GameMethods
---@field exit fun(self: GameSelf)
---@field pause fun(self: GameSelf)
---@field restart fun(self: GameSelf)
---@field resume fun(self: GameSelf)
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
        loopManager = nil,
        sceneManager = nil,
        music = nil,
    },

    methods = {
        exit = function()
            os.exit()
        end,

        pause = function(self)
            self.loopManager.pauseAll()
            self.music.pause()
            self.sceneManager.gotoPause()
        end,

        restart = function(self)
            self.music.stop()
            self.sceneManager.gotoWorld(true)
            self.music.play()
        end,

        resume = function(self)
            self.sceneManager.gotoWorld()
            self.music.resume()
            self.loopManager.resumeAll()
        end,

        run = function(self)
            self.sceneManager.gotoStart()
            self.music.play()
        end,

        start = function(self)
            self.music.stop()
            self.sceneManager.gotoWorld(true)
            self.music.play()
        end,
    },

    initializer = function(initial, attributes)
        if attributes.loopManager == nil and attributes.sceneManager == nil and attributes.music == nil then
            attributes.loopManager = LoopManager()
            attributes.sceneManager = SceneManager(initial.scenePaths)
            attributes.music = Music(initial.musicPath)
        end
    end,

    finalizer = function(attributes)
        if attributes.loopManager ~= nil and attributes.sceneManager ~= nil and attributes.music ~= nil then
            attributes.loopManager = nil
            attributes.sceneManager = nil
            attributes.music = nil
        end
    end,
}

return Game
