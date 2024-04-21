local display = require("display")

---@param path string
local BackgroundImage = function (path)
    local imageRect = nil
    local sceneGroup = nil

    local function destroy()
        if imageRect ~= nil and sceneGroup ~= nil then
            sceneGroup.remove(sceneGroup, imageRect)

            imageRect.removeSelf(imageRect)
            imageRect = nil
        end
    end

    ---@param group table
    local function create(group)
        sceneGroup = group

        if imageRect == nil and sceneGroup ~= nil then
            imageRect = display.newImageRect(path, display.pixelWidth, display.pixelHeight)

            imageRect.x = display.contentCenterX
            imageRect.y = display.contnetCenterY

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

    ---@class BackgroundImage
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field insertSceneGroup function
    ---@field show function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        insertSceneGroup = insertSceneGroup,
        show = show
    }
end

return BackgroundImage
