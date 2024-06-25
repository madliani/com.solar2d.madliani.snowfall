local display = require "display"

---@param title Title
---@param coordinate Coordinate
---@param event Event?
local Label = function(title, coordinate, event)
    ---@type table | nil
    local label = nil

    ---@type table | nil
    local sceneGroup = nil

    ---@type string | nil
    local textBackup = nil

    local function destroy()
        if label ~= nil and sceneGroup ~= nil and textBackup ~= nil then
            sceneGroup.remove(sceneGroup, label)

            label = nil
            sceneGroup = nil
            textBackup = nil
        end
    end

    ---@param group table
    local function create(group)
        sceneGroup = group

        if label == nil and sceneGroup ~= nil then
            label = display.newText(title.text, coordinate.x, coordinate.y, title.font, title.size)

            label.setFillColor(label, title.color.red, title.color.green, title.color.blue)

            if event ~= nil then
                label.addEventListener(label, event.type, event.action)
            end

            sceneGroup.insert(sceneGroup, label)
        end
    end

    local function show()
        if label ~= nil then
            label.isVisible = true
        end
    end

    local function hide()
        if label ~= nil then
            label.isVisible = false
        end
    end

    local function updateText(newText)
        if label ~= nil then
            label.text = newText
        end
    end

    ---@class Label
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field show function
    ---@field updateText function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        show = show,
        updateText = updateText,
    }
end

return Label
