local audio = require("audio")

local Sound = (function ()
    local sound = nil
    local volume = nil

    local function finalize()
        if sound ~= nil and volume ~= nil then
            audio.setVolume(0)

            sound = nil
            volume = nil
        end
    end

    ---@param path string
    local function initialize(path)
        if sound == nil and volume == nil then
            sound = audio.loadSound(path)
            volume = audio.getVolume()

            audio.play(sound)
        end
    end

    local function unmute()
        if sound ~= nil then
            audio.setVolume(volume)
        end
    end

    local function mute()
        if sound ~= nil then
            audio.setVolume(0)
        end
    end

    return function ()
        ---@class Sound
        ---@field finalize function
        ---@field initialize function
        ---@field mute function
        ---@field unmute function
        return {
            finalize = finalize,
            initialize = initialize,
            mute = mute,
            unmute = unmute
        }
    end
end)()

return Sound
