local audio = require "audio"

local Sound = (function()
    ---@type table | nil
    local sound = nil

    ---@type integer | nil
    local volume = nil

    local function destroy()
        if sound ~= nil and volume ~= nil then
            audio.setVolume(0)

            sound = nil
            volume = nil
        end
    end

    ---@param path string
    local function create(path)
        if sound == nil and volume == nil then
            sound = audio.loadSound(path)
            volume = audio.getVolume()

            audio.play(sound)
        end
    end

    local function show()
        if sound ~= nil then audio.setVolume(volume) end
    end

    local function hide()
        if sound ~= nil then audio.setVolume(0) end
    end

    return function()
        ---@class Sound
        ---@field finalize function
        ---@field initialize function
        ---@field mute function
        ---@field unmute function
        return {
            finalize = destroy,
            initialize = create,
            mute = hide,
            unmute = show,
        }
    end
end)()

return Sound
