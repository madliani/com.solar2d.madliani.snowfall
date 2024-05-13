local display = require "display"

---@param path string
---@param width integer
---@param height integer
---@param x integer
---@param y integer
local Image = function(path, width, height, x, y)
    ---@type table | nil
    local imageRect = nil

    ---@type table | nil
    local sceneGroup = nil

    local function destroy()
        if imageRect ~= nil and sceneGroup ~= nil then
            sceneGroup.remove(sceneGroup, imageRect)

            imageRect.removeSelf(imageRect)

            imageRect = nil
            sceneGroup = nil
        end
    end

    ---@param group table
    local function create(group)
        sceneGroup = group

        if imageRect == nil and sceneGroup ~= nil then
            imageRect = display.newImageRect(path, width, height)

            imageRect.x = x
            imageRect.y = y

            sceneGroup.insert(sceneGroup, imageRect)
        end
    end

    local function show()
        if imageRect ~= nil then
            imageRect.isVisible = true
        end
    end

    local function hide()
        if imageRect ~= nil then
            imageRect.isVisible = false
        end
    end

    ---@class Image
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field show function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        show = show,
    }
end

return Image
