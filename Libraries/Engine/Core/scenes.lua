local composer = require "composer"

---@alias ScenePath string

---@class ScenePaths
---@field start ScenePath
---@field world ScenePath

---@param paths ScenePaths
local Scenes = function(paths)
	---@type ScenePaths | nil
	local scenes = paths

	---@type string | nil
    local activeScene = nil

    local function destroy()
        activeScene = nil

        scenes.start = nil
        scenes.world = nil

		scenes = nil
    end

    local function gotoScene(scene)
        if activeScene ~= nil then
            composer.removeScene(activeScene)
        end

        activeScene = scene

        composer.gotoScene(scene)
    end

    local function gotoStart()
        if scenes ~= nil then
			gotoScene(scenes.start)
		end
    end

    local function gotoWorld()
        if scenes ~= nil then
			gotoScene(scenes.world)
		end
    end

    return {
        destroy = destroy,
        gotoStart = gotoStart,
        gotoWorld = gotoWorld,
    }
end

return Scenes
