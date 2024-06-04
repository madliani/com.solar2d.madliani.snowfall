local audio = require "audio"

---@alias MusicPath string

---@class Music
---@field unmute fun()
---@field mute fun()

---@alias MusicClass fun(path: MusicPath): Music
---@alias MusicIdentificator string

---@class MusicAttributes
---@field sound table | nil
---@field volume integer | nil

---@class MusicSelf
---@field sound table
---@field volume integer
---@field unmute fun(self: MusicSelf)
---@field mute fun(self: MusicSelf)

---@class MusicMethods
---@field unmute fun(self: MusicSelf)
---@field mute fun(self: MusicSelf)

---@alias MusicInitializer fun(initial: MusicPath, attributes: MusicAttributes)
---@alias MusicFinalizer fun(attributes: MusicAttributes)

---@class MusicMetaclass
---@field id MusicIdentificator
---@field attributes MusicAttributes
---@field initializer MusicInitializer
---@field finalizer MusicFinalizer
---@field methods MusicMethods

---@alias MusicSingleton fun(metaclass: MusicMetaclass): MusicClass

---@type MusicSingleton
local Singleton = require "Libraries.Prelude.singleton"

local Music = Singleton {
    id = "music",

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

return Music
