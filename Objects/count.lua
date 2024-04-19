local display = require("display")
local native = require("native")

---@param initialCount integer
local Count = function (initialCount)
    local text = nil
    local sceneGroup = nil
    local countBackup = nil

    ---@param group table
    local function insertSceneGroup(group)
        sceneGroup = group
    end

    local function destroy()
        if text ~= nil and sceneGroup ~= nil and countBackup ~= nil then
            sceneGroup.remove(sceneGroup, text)

            text = nil
            countBackup = nil
        end
    end

    local function create()
        if text == nil and sceneGroup ~= nil then
            local coordinate = {
                x = display.contentCenterX,
                y = 1
            }

            local font = {
                family = native.systemFont,
                size = 48
            }

            local color = {
                red = 0,
                green = 0,
                blue = 0
            }

            text = display.newText(initialCount, coordinate.x, coordinate.y, font.family, font.size)

            text.setFillColor(text, color.red, color.green, color.blue)

            sceneGroup.insert(sceneGroup, text)
        end
    end

    local function show()
        if text ~= nil and countBackup ~= nil then
            text.text = countBackup
        end
    end

    local function hide()
        if text ~= nil then
            text.text = ""
        end
    end

    local function inc()
        if text ~= nil then
            text.text = text.text + 1
        end
    end

    local function dec()
        if text ~= nil then
            text.text = text.text - 1
        end
    end

    ---@class Count
    ---@field create function
    ---@field dec function
    ---@field destroy function
    ---@field hide function
    ---@field inc function
    ---@field insertSceneGroup function
    ---@field show function
    return {
        create = create,
        dec = dec,
        destroy = destroy,
        hide = hide,
        inc = inc,
        insertSceneGroup = insertSceneGroup,
        show = show
    }
end

return Count
