local display = require("display")

---@param title integer
---@param coordinate table
---@param font table
---@param color table
local Label = function (title, coordinate, font, color)
    local label = nil
    local sceneGroup = nil
    local titleBackup = nil

    ---@param group table
    local function insertSceneGroup(group)
        sceneGroup = group
    end

    local function destroy()
        if label ~= nil and sceneGroup ~= nil and titleBackup ~= nil then
            sceneGroup.remove(sceneGroup, label)

            label = nil
            titleBackup = nil
        end
    end

    local function create()
        if label == nil and sceneGroup ~= nil then
            label = display.newText(title, coordinate.x, coordinate.y, font.family, font.size)

            label.setFillColor(label, color.red, color.green, color.blue)

            sceneGroup.insert(sceneGroup, label)
        end
    end

    local function show()
        if label ~= nil and titleBackup ~= nil then
            label.text = titleBackup
        end
    end

    local function hide()
        if label ~= nil then
            label.text = ""
        end
    end

    local function updateTitle(newTitle)
        if label ~= nil then
            label.text = newTitle
        end
    end

    ---@class Label
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field insertSceneGroup function
    ---@field show function
    ---@field updateTitle function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        insertSceneGroup = insertSceneGroup,
        show = show,
        updateTitle = updateTitle
    }
end

return Label
