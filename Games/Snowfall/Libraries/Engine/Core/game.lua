local LoopManager = require "Libraries.Engine.Middleware.loopManager"
local Audio = require "Libraries.Engine.Core.audio"
local SceneManager = require "Libraries.Engine.Middleware.sceneManager"
local _ = require "Libraries.Prelude.enumerable"
local os = require "os"

---@class GameInitial
---@field music MusicPath

---@class Game
---@field exit fun()
---@field pause fun(destionation: ScenePath)
---@field restart fun(source: ScenePath, destionation: ScenePath)
---@field resume fun(source: ScenePath, destionation: ScenePath)
---@field run fun(destionation: ScenePath)
---@field start fun(source: ScenePath, destionation: ScenePath)

---@alias GameClass fun(initial: GameInitial): Game
---@alias GameIdentificator string

---@class GameAttributes
---@field loopManager LoopManager | nil
---@field audio Audio | nil
---@field sceneManager SceneManager | nil

---@class GameSelf: GameAttributes, GameMethods

---@class GameMethods
---@field exit fun(self: GameSelf)
---@field pause fun(self: GameSelf, destionation: ScenePath)
---@field restart fun(self: GameSelf, source: ScenePath, destionation: ScenePath)
---@field resume fun(self: GameSelf, source: ScenePath, destionation: ScenePath)
---@field run fun(self: GameSelf, destionation: ScenePath)
---@field start fun(self: GameSelf, source: ScenePath, destionation: ScenePath)

---@alias GameInitializer fun(initial: GameInitial, attributes: GameAttributes)
---@alias GameFinalizer fun(attributes: GameAttributes)

---@class GamePrototype
---@field id GameIdentificator
---@field attributes GameAttributes
---@field initializer GameInitializer
---@field finalizer GameFinalizer
---@field methods GameMethods

---@alias GameSingleton fun(prototype: GamePrototype): GameClass

---@type GameSingleton
local Singleton = require "Libraries.Prelude.singleton"

local Game = Singleton {
    id = "game",

    attributes = {
        loopManager = nil,
        sceneManager = nil,
        audio = nil,
    },

    methods = {
        exit = function(_)
            os.exit()
        end,

        pause = function(self, destination)
            self.loopManager.pauseAll()
            self.audio.pause()

            self.sceneManager.gotoScene(destination, "slideRight", 150)
        end,

        restart = function(self, source, destionation)
            self.loopManager.removeAll()
            self.audio.stop()

            self.sceneManager.removeScene(destionation)
            self.sceneManager.removeScene(source)
            self.sceneManager.gotoScene(destionation, "slideRight", 150)

            self.audio.play()
        end,

        resume = function(self, source, destionation)
            self.sceneManager.removeScene(source)
            self.sceneManager.gotoScene(destionation, "slideRight", 150)

            self.audio.resume()
            self.loopManager.resumeAll()
        end,

        run = function(self, destionation)
            self.sceneManager.gotoScene(destionation, "slideRight", 150)
            self.audio.play()
        end,

        start = function(self, source, destionation)
            self.audio.stop()

            self.sceneManager.removeScene(source)
            self.sceneManager.gotoScene(destionation, "slideRight", 150)

            self.audio.play()
        end,
    },

    initializer = function(initial, attributes)
        if attributes.loopManager == nil and attributes.sceneManager == nil and attributes.audio == nil then
            attributes.loopManager = LoopManager()
            attributes.sceneManager = SceneManager()
            attributes.audio = Audio(initial.music)
        end
    end,

    finalizer = function(attributes)
        if attributes.loopManager ~= nil and attributes.sceneManager ~= nil and attributes.audio ~= nil then
            attributes.loopManager = nil
            attributes.sceneManager = nil
            attributes.audio = nil
        end
    end,
}

return Game
