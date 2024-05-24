local os = require "os"

local Resources = require "resources"

local Singleton = require "Libraries.Prelude.singleton"

---@class Game
---@field exit fun(self?: table<Attribute>)
---@field run fun(self?: table<Attribute>)
---@field start fun(self?: table<Attribute>)

---@type fun(initial: table<unknown>): Game
local Game = Singleton {
    id = "Game",
    attributes = {
        scenes = nil,
        sound = nil,
    },
    methods = {
        exit = function(self)
            if self.sound ~= nil then
                self.sound.finalize()
                self.scenes.destroy()

                self.sound = nil
                self.scenes = nil

                os.exit()
            end
        end,
        run = function(self)
            if self.sound ~= nil and self.scenes ~= nil then
                self.sound.initialize(Resources.Sounds.background)
                self.scenes.gotoStart()
            end
        end,
        start = function(self)
            if self.scenes ~= nil then
                self.scenes.gotoWorld()
            end
        end,
    },
}

return Game
