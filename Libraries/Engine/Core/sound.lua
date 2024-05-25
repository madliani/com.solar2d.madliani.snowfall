local audio = require "audio"

---@class SoundAttributes
---@field sound table | nil
---@field volume integer | nil

---@class SoundMethods
---@field finalize fun(self: SoundAttributes)
---@field initialize fun(self: SoundAttributes, path: string)
---@field unmute fun(self: SoundAttributes)
---@field mute fun(self: SoundAttributes)

---@class SoundClass
---@field attributes SoundAttributes
---@field methods SoundMethods

---@class Sound
---@field finalize fun()
---@field initialize fun(path: string)
---@field unmute fun()
---@field mute fun()

---@alias SoundSingleton fun(class: SoundClass): Sound

---@type SoundSingleton
local Singleton = require "Libraries.Prelude.singleton"

local Sound = Singleton {
    attributes = {
        sound = nil,
        volume = nil,
    },

    methods = {
        finalize = function(self)
            if self.sound ~= nil and self.volume ~= nil then
                audio.setVolume(0)

                self.sound = nil
                self.volume = nil
            end
        end,

        initialize = function(self, path)
            if self.sound == nil and self.volume == nil then
                self.sound = audio.loadSound(path)
                self.volume = audio.getVolume()

                audio.play(self.sound)
            end
        end,

        unmute = function(self)
            if self.sound ~= nil then
                audio.setVolume(self.volume)
            end
        end,

        mute = function(self)
            if self.sound ~= nil then
                audio.setVolume(0)
            end
        end,
    },
}

return Sound
