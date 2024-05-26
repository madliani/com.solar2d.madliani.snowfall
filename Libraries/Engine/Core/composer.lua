local composer = require "composer"

---@alias ScenePath string

---@class ScenePaths
---@field start ScenePath
---@field world ScenePath

---@param paths ScenePaths
local Composer = function(paths)
    ---@type ScenePaths | nil
    local scenePaths = paths

    ---@type string | nil
    local activeScene = nil

    local function destroy()
        activeScene = nil

        scenePaths.start = nil
        scenePaths.world = nil

        scenePaths = nil
    end

    local function gotoScene(scene)
        if activeScene ~= nil then
            composer.removeScene(activeScene)
        end

        activeScene = scene

        composer.gotoScene(scene)
    end

    local function gotoStart()
        if scenePaths ~= nil then
            gotoScene(scenePaths.start)
        end
    end

    local function gotoWorld()
        if scenePaths ~= nil then
            gotoScene(scenePaths.world)
        end
    end

    ---@class Composer
    ---@field destroy function
    ---@field gotoStart function
    ---@field gotoWorld function
    return {
        destroy = destroy,
        gotoStart = gotoStart,
        gotoWorld = gotoWorld,
    }
end

return Composer
