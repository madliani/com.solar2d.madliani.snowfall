local display = require("display")

---@param path string
local Snowflake = function (path)
    local imageRect = nil
    local sceneGroup = nil

    ---@param group table
    local function insertSceneGroup(group)
        sceneGroup = group
    end

    local function destroy()
        if imageRect ~= nil and sceneGroup ~= nil then
            sceneGroup.remove(sceneGroup, imageRect)
            imageRect.removeSelf(imageRect)

            imageRect = nil
        end
    end

    local function create()
        if imageRect == nil and sceneGroup ~= nil then
            local scale = math.random(5, 15)
            local width = display.pixelWidth / display.contentWidth * scale
            local height = display.pixelWidth / display.contentWidth * scale

            imageRect = display.newImageRect(path, width, height)

            imageRect.x = math.random(display.contentWidth)
            imageRect.y = -imageRect.contentHeight

            sceneGroup.insert(sceneGroup, imageRect)
            imageRect.addEventListener(imageRect, "tap", destroy)
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

    local function isRemovable()
        if imageRect ~= nil then
            return imageRect.y >= display.contentHeight
        end
    end

    local function update()
        if imageRect ~= nil then
            imageRect.y = imageRect.y + 1

            if isRemovable() then
                destroy()
            end
        end
    end

    local function isUnavable()
        return imageRect == nil
    end

    ---@class Snowflake
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field insertSceneGroup function
    ---@field isUnavable function
    ---@field show function
    ---@field update function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        insertSceneGroup = insertSceneGroup,
        isUnavable = isUnavable,
        show = show,
        update = update
    }
end

return Snowflake
