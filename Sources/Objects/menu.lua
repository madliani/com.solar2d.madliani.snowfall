local display = require "display"

local Resources = require "resources"

local ButtonGroup = require "Libraries.Engine.Widgets.buttonGroup"
local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Size = require "Libraries.Engine.Core.size"
local Title = require "Libraries.Engine.Core.title"

local gap = 100
local systemFont = Font "system"
local color = Color(0, 0, 0)
local size = Size(190, 45)

---@param items table<any>[]
local Menu = function(items)
    ---@type unknown[]
    local menu = {}

    ---@type ButtonGroup | nil
    local buttonGroup = nil

    local function destroy()
        if buttonGroup ~= nil then
            buttonGroup.destroy()
        end
    end

    ---@param group table
    local function create(group)
        for i = 1, #items, 1 do
            local step = i - 1

            local title = Title(items[i].text, systemFont, color, 24)
            local coordinate = Coordinate(display.contentCenterX, 150 + gap * step)

            local item = {
                path = Resources.Images.yellowButton,
                title = title,
                size = size,
                coordinate = coordinate,
                event = items[i].event,
            }

            table.insert(menu, item)
        end

        buttonGroup = ButtonGroup(menu)

        buttonGroup.create(group)
    end

    local function show()
        if buttonGroup ~= nil then
            buttonGroup.show()
        end
    end

    local function hide()
        if buttonGroup ~= nil then
            buttonGroup.hide()
        end
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

return Menu
