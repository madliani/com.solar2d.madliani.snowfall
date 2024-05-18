local display = require "display"
local native = require "native"

local Color = require "Libraries.Engine.color"
local Coordinate = require "Libraries.Engine.coordinate"
local Label = require "Libraries.Engine.label"
local Title = require "Libraries.Engine.title"

local color = Color(0, 0, 0)

---@param initialCount integer
local Count = function(initialCount)
    local count = initialCount

    local title = Title(color, tostring(count), native.systemFont, 36)
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
