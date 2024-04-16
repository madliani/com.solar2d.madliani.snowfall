local audio = require("audio")

---@param path string
local BackgroundSound = function (path)
    local sound = nil
    local volume = nil

    local function create()
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

    local function destroy()
        if sound ~= nil and volume ~= nil then
            audio.setVolume(0)

            sound = nil
            volume = nil
        end
    end

    ---@class BackgroundSound
    ---@field create function
    ---@field destroy function
    ---@field mute function
    ---@field unmute function
    return {
        create = create,
        destroy = destroy,
        mute = mute,
        unmute = unmute
    }
end

return BackgroundSound
