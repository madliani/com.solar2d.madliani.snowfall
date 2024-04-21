local display = require("display")

---@param initialTitle integer
---@param coordinate table
---@param font table
---@param color table
local Label = function (initialTitle, coordinate, font, color)
    local title = nil
    local sceneGroup = nil
    local titleBackup = nil

    ---@param group table
    local function insertSceneGroup(group)
        sceneGroup = group
    end

    local function destroy()
        if title ~= nil and sceneGroup ~= nil and titleBackup ~= nil then
            sceneGroup.remove(sceneGroup, title)

            title = nil
            titleBackup = nil
        end
    end

    local function create()
        if title == nil and sceneGroup ~= nil then
            title = display.newText(initialTitle, coordinate.x, coordinate.y, font.family, font.size)

            title.setFillColor(title, color.red, color.green, color.blue)

            sceneGroup.insert(sceneGroup, title)
        end
    end

    local function show()
        if title ~= nil and titleBackup ~= nil then
            title.text = titleBackup
        end
    end

    local function hide()
        if title ~= nil then
            title.text = ""
        end
    end

    local function updateTitle(newTitle)
        if title ~= nil then
            title.text = newTitle
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
