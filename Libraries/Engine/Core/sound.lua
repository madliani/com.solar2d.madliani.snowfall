local audio = require "audio"

---@alias SoundPath string

---@class Sound
---@field unmute fun()
---@field mute fun()

---@alias SoundClass fun(path: SoundPath): Sound
---@alias SoundIdentificator string

---@class SoundAttributes
---@field sound table | nil
---@field volume integer | nil

---@class SoundSelf
---@field sound table
---@field volume integer
---@field unmute fun(self: SoundSelf)
---@field mute fun(self: SoundSelf)

---@class SoundMethods
---@field unmute fun(self: SoundSelf)
---@field mute fun(self: SoundSelf)

---@alias SoundInitializer fun(initial: SoundPath, attributes: SoundAttributes)
---@alias SoundFinalizer fun(attributes: SoundAttributes)

---@class SoundMetaclass
---@field id SoundIdentificator
---@field attributes SoundAttributes
---@field initializer SoundInitializer
---@field finalizer SoundFinalizer
---@field methods SoundMethods

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
        unmute = function(self)
            audio.setVolume(self.volume)
        end,

        mute = function()
            audio.setVolume(0)
        end,
    },

    initializer = function(path, attributes)
        if attributes.sound == nil and attributes.volume == nil then
            attributes.sound = audio.loadSound(path)
            attributes.volume = audio.getVolume()
        end

        audio.play(attributes.sound)
    end,

    finalizer = function(attributes)
        audio.setVolume(0)

        if attributes.sound ~= nil and attributes.volume ~= nil then
            attributes.sound = nil
            attributes.volume = nil
        end
    end,
}

return Sound
