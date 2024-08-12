local audio = require "audio"

---@alias MusicPath string

---@class Music
---@field mute fun()
---@field pause fun()
---@field play fun()
---@field resume fun()
---@field stop fun()
---@field unmute fun()

---@alias MusicClass fun(path: MusicPath): Music
---@alias MusicIdentificator string

---@class MusicAttributes
---@field audio table | nil
---@field music table | nil
---@field volume integer | nil

---@class MusicSelf
---@field audio table
---@field music table
---@field volume integer
---@field mute fun(self: MusicSelf)
---@field pause fun(self: MusicSelf)
---@field play fun(self: MusicSelf)
---@field resume fun(self: MusicSelf)
---@field stop fun(self: MusicSelf)
---@field unmute fun(self: MusicSelf)

---@class MusicMethods
---@field mute fun(self: MusicSelf)
---@field pause fun(self: MusicSelf)
---@field play fun(self: MusicSelf)
---@field resume fun(self: MusicSelf)
---@field stop fun(self: MusicSelf)
---@field unmute fun(self: MusicSelf)

---@alias MusicInitializer fun(initial: MusicPath, attributes: MusicAttributes)
---@alias MusicFinalizer fun(attributes: MusicAttributes)

---@class MusicPrototype
---@field id MusicIdentificator
---@field attributes MusicAttributes
---@field initializer MusicInitializer
---@field finalizer MusicFinalizer
---@field methods MusicMethods

---@alias MusicSingleton fun(prototype: MusicPrototype): MusicClass

---@type MusicSingleton
local Singleton = require "Libraries.Prelude.singleton"

local Audio = Singleton {
    id = "audio",

    attributes = {
        audio = nil,
        music = nil,
        volume = nil,
    },

    methods = {
        mute = function()
            audio.setVolume(0)
        end,

        pause = function(self)
            audio.pause(self.music)
        end,

        play = function(self)
            self.music = audio.play(self.audio)
        end,

        resume = function(self)
            audio.resume(self.music)
        end,

        stop = function(self)
            audio.stop(self.music)
        end,

        unmute = function(self)
            audio.setVolume(self.volume)
        end,
    },

    initializer = function(path, attributes)
        if attributes.audio == nil and attributes.music == nil and attributes.volume == nil then
            attributes.audio = audio.loadSound(path)
        end
    end,

    finalizer = function(attributes)
        if attributes.audio == nil and attributes.music ~= nil and attributes.volume ~= nil then
            attributes.audio = nil
            attributes.music = nil
            attributes.volume = nil
        end
    end,
}

return Audio
