local display = require("display")

---@param label table
---@param action? table
local Button = function (label, action)
    local title = label.title
    local coordinate = label.coordinate
    local font = label.font
    local color = label.color

    ---@type table | nil
    local button = nil

    ---@type table | nil
    local sceneGroup = nil

    ---@type string | nil
    local titleBackup = nil

    local function destroy()
        if button ~= nil and sceneGroup ~= nil and titleBackup ~= nil then
            sceneGroup.remove(sceneGroup, button)

            button = nil
            sceneGroup = nil
            titleBackup = nil
        end
    end

    ---@param group table
    local function create(group)
        sceneGroup = group

        if button == nil and sceneGroup ~= nil then
            button = display.newText(title, coordinate.x, coordinate.y, font.family, font.size)

            button.setFillColor(button, color.red, color.green, color.blue)

            sceneGroup.insert(sceneGroup, button)
        end

        if button ~= nil and action ~= nil then
            button.addEventListener(button, action.type, action.method)
        end
    end

    local function show()
        if button ~= nil and titleBackup ~= nil then
            button.text = titleBackup
        end
    end

    local function hide()
        if button ~= nil then
            button.text = ""
        end
    end

    local function updateTitle(newTitle)
        if button ~= nil then
            button.text = newTitle
        end
    end

    ---@class Button
    ---@field create function
    ---@field destroy function
    ---@field hide function
    ---@field show function
    ---@field updateTitle function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        show = show,
        updateTitle = updateTitle
    }
end

return Button
