local display = require("display")

---@param path string
---@param counter Counter
local Snowflake = function (path, counter)
    local imageRect = nil
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
            local scale = math.random(5, 15)
            local width = display.pixelWidth / display.contentWidth * scale
            local height = display.pixelWidth / display.contentWidth * scale

            local function onTap()
                destroy()
                counter.inc()
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
        local function isRemovable()
            if imageRect ~= nil then
                return imageRect.y >= display.contentHeight
            end
        end

        local function incCoordinateY()
            if imageRect ~= nil then
                imageRect.y = imageRect.y + 1
            end
        end

        if imageRect ~= nil then
            if isRemovable() then
                destroy()
            else
                incCoordinateY()
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
    ---@field isUnavable function
    ---@field show function
    ---@field update function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        isUnavable = isUnavable,
        show = show,
        update = update
    }
end

return Snowflake
