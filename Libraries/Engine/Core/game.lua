local Resources = require "resources"
local os = require "os"

---@alias GameIdentificator string

---@class GameAttributes
---@field sceneManager SceneManager | nil
---@field sound Sound | nil

---@class GameMethods
---@field exit fun(self: GameAttributes)
---@field run fun(self: GameAttributes)
---@field start fun(self: GameAttributes)

---@class GameClass
---@field id GameIdentificator
---@field attributes GameAttributes
---@field methods GameMethods

---@class Game
---@field exit fun()
---@field run fun()
---@field start fun()

---@alias GameSingleton fun(class: GameClass): Game

---@type GameSingleton
local Singleton = require "Libraries.Prelude.singleton"

local Game = Singleton {
    id = "Game",
    attributes = {
        sceneManager = nil,
        sound = nil,
    },
    methods = {
        exit = function(self)
            if self.sound ~= nil and self.sceneManager ~= nil then
                self.sound.finalize()
                self.sceneManager.destroy()

                self.sound = nil
                self.sceneManager = nil

                os.exit()
            end
        end,
        run = function(self)
            if self.sound ~= nil and self.sceneManager ~= nil then
                self.sound.initialize(Resources.Sounds.background)
                self.sceneManager.gotoStart()
            end
        end,
        start = function(self)
            if self.sceneManager ~= nil then
                self.sceneManager.gotoWorld()
            end
        end,
    },
}

return Game
