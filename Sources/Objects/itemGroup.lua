local display = require "display"
local native = require "native"

local ButtonGroup = require "Libraries.Engine.buttonGroup"

---@param items table
local ItemGroup = function(items)
    ---@type table
    local itemGroup = {}

    local font = {
        family = native.systemFont,
        size = 48,
    }

    local color = {
        red = 0,
        green = 0,
        blue = 0,
    }

    for i = 1, #items, 1 do
        local title = items[i].title
        local action = items[i].action

        local gap = 100
        local step = i - 1

        local coordinate = {
            x = display.contentCenterX,
            y = 100 + gap * step,
        }

        local label = {
            title = title,
            coordinate = coordinate,
            font = font,
            color = color,
        }

        local item = {
            label = label,
            action = action,
        }

        table.insert(itemGroup, item)
    end

    local buttonGroup = ButtonGroup(itemGroup)

    local function destroy() buttonGroup.destroy() end

    ---@param group table
    local function create(group) buttonGroup.create(group) end

    local function show() buttonGroup.show() end

    local function hide() buttonGroup.hide() end

    ---@class ItemGroup
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

return ItemGroup
