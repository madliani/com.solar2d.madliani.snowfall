local display = require "display"
local native = require "native"

local ButtonGroup = require "Libraries.Engine.buttonGroup"
local Color = require "Libraries.Engine.color"
local Coordinate = require "Libraries.Engine.coordinate"
local Font = require "Libraries.Engine.font"
local Label = require "Libraries.Engine.label"

local font = Font(native.systemFont, 48)
local color = Color(0, 0, 0)

---@param items table
local ItemGroup = function(items)
    ---@type unknown[]
    local itemGroup = {}

    local buttonGroup = ButtonGroup(itemGroup)

    local function destroy()
        buttonGroup.destroy()
    end

    ---@param group table
    local function create(group)
        for i = 1, #items, 1 do
            local title = items[i].title
            local action = items[i].action

            local gap = 100
            local step = i - 1

            local coordinate = Coordinate(display.contentCenterX, 100 + gap * step)
            local label = Label(title, coordinate, font, color)

            local item = {
                label = label,
                action = action,
            }

            table.insert(itemGroup, item)
        end

        buttonGroup.create(group)
    end

    local function show()
        buttonGroup.show()
    end

    local function hide()
        buttonGroup.hide()
    end

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
