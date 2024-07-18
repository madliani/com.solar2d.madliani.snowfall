local display = require "display"

---@param path string
---@param scoreCounter ScoreCounter
local Snowflake = function(path, scoreCounter)
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

        if imageRect == nil and sceneGroup ~= nil and display ~= nil then
            local scale = math.random(5, 15)
            local width = display.pixelWidth / display.contentWidth * scale
            local height = display.pixelWidth / display.contentWidth * scale

            local function onTap()
                destroy()
                scoreCounter.inc()
            end

            imageRect = display.newImageRect(path, width, height)

            imageRect.x = math.random(display.contentWidth)
            imageRect.y = -imageRect.contentHeight

            sceneGroup.insert(sceneGroup, imageRect)
            imageRect.addEventListener(imageRect, "tap", onTap)
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

    local function update()
        local function incCoordinateY()
            if imageRect ~= nil then
                imageRect.y = imageRect.y + 1
            end
        end

        incCoordinateY()
    end

    local function isUnavable()
        if imageRect ~= nil and display ~= nil then
            return imageRect.y >= display.contentHeight
        end

        return false
    end

    ---@class Snowflake
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field isUnavable function
    ---@field show function
    ---@field update function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        isUnavable = isUnavable,
        show = show,
        update = update,
    }
end

return Snowflake
