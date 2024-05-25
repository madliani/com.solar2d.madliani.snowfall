local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Label = require "Libraries.Engine.Widgets.label"
local Resources = require "resources"
local Title = require "Libraries.Engine.Core.title"
local display = require "display"

local color = Color(0, 0, 0)
local font = Font(Resources.Fonts.architectsDaughter)

---@param initialCount integer
local Count = function(initialCount)
    local count = initialCount

    local title = Title(tostring(count), font, color, 48)
    local coordinate = Coordinate(display.contentCenterX, 1)
    local label = Label(title, coordinate)

    local function destroy()
        label.destroy()
    end

    ---@param group table
    local function create(group)
        label.create(group)
    end

    local function show()
        label.show()
    end

    local function hide()
        label.hide()
    end

    local function inc()
        count = count + 1

        label.updateText(tostring(count))
    end

    local function dec()
        count = count - 1

        label.updateText(tostring(count))
    end

    ---@class Count
    ---@field create function
    ---@field dec function
    ---@field destroy function
    ---@field hide function
    ---@field inc function
    ---@field show function
    return {
        create = create,
        dec = dec,
        destroy = destroy,
        hide = hide,
        inc = inc,
        show = show,
    }
end

return Count
