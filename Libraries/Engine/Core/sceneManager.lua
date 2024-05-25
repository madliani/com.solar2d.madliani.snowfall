local composer = require "composer"

---@alias ScenePath string

---@class ScenePaths
---@field start ScenePath
---@field world ScenePath

---@param paths ScenePaths
local SceneManager = function(paths)
    ---@type ScenePaths | nil
    local scenePaths = paths

    ---@type string | nil
    local activePath = nil

    local function destroy()
        activePath = nil

        scenePaths.start = nil
        scenePaths.world = nil

        scenePaths = nil
    end

    local function gotoScene(scene)
        if activePath ~= nil then
            composer.removeScene(activePath)
        end

        activePath = scene

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

    ---@class SceneManager
    ---@field destroy function
    ---@field gotoStart function
    ---@field gotoWorld function
    return {
        destroy = destroy,
        gotoStart = gotoStart,
        gotoWorld = gotoWorld,
    }
end

return SceneManager
