local audio = require "audio"

---@alias SoundIdentificator string

---@class SoundAttributes
---@field sound table | nil
---@field volume integer | nil

---@class SoundSelf
---@field sound table | nil
---@field volume integer | nil
---@field finalize fun(self: SoundSelf)
---@field initialize fun(self: SoundSelf, path: string)
---@field unmute fun(self: SoundSelf)
---@field mute fun(self: SoundSelf)

---@class SoundMethods
---@field finalize fun(self: SoundSelf)
---@field initialize fun(self: SoundSelf, path: string)
---@field unmute fun(self: SoundSelf)
---@field mute fun(self: SoundSelf)

---@class SoundMetaclass
---@field id SoundIdentificator
---@field attributes SoundAttributes
---@field methods SoundMethods

---@class Sound
---@field finalize fun()
---@field initialize fun(path: string)
---@field unmute fun()
---@field mute fun()

---@alias SoundClass fun(): Sound

---@alias SoundSingleton fun(metaclass: SoundMetaclass): SoundClass

---@type SoundSingleton
local Singleton = require "Libraries.Prelude.singleton"

local Sound = Singleton {
    id = "sound",

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
