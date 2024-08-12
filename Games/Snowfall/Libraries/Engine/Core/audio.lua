local audio = require "audio"

---@alias AudioPath string

---@class Audio
---@field mute fun()
---@field pause fun()
---@field play fun()
---@field resume fun()
---@field stop fun()
---@field unmute fun()

---@alias AudioClass fun(path: AudioPath): Audio
---@alias AudioIdentificator string

---@class AudioAttributes
---@field audio table | nil
---@field music table | nil
---@field volume integer | nil

---@class AudioSelf
---@field audio table
---@field music table
---@field volume integer
---@field mute fun(self: AudioSelf)
---@field pause fun(self: AudioSelf)
---@field play fun(self: AudioSelf)
---@field resume fun(self: AudioSelf)
---@field stop fun(self: AudioSelf)
---@field unmute fun(self: AudioSelf)

---@class AudioMethods
---@field mute fun(self: AudioSelf)
---@field pause fun(self: AudioSelf)
---@field play fun(self: AudioSelf)
---@field resume fun(self: AudioSelf)
---@field stop fun(self: AudioSelf)
---@field unmute fun(self: AudioSelf)

---@alias AudioInitializer fun(initial: AudioPath, attributes: AudioAttributes)
---@alias AudioFinalizer fun(attributes: AudioAttributes)

---@class AudioPrototype
---@field id AudioIdentificator
---@field attributes AudioAttributes
---@field initializer AudioInitializer
---@field finalizer AudioFinalizer
---@field methods AudioMethods

---@alias AudioSingleton fun(prototype: AudioPrototype): AudioClass

---@type AudioSingleton
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
