local display = require("display")
local native = require("native")

local Button = require("Objects.button")

---@param initialCount integer
local Count = function (initialCount)
    local count = initialCount

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

    local label = {
        title = initialCount,
        coordinate = coordinate,
        font = font,
        color = color
    }

    local button = Button(label)

    ---@param group table
    local function insertSceneGroup(group)
        button.insertSceneGroup(group)
    end

    local function destroy()
        button.destroy()
    end

    local function create()
        button.create()
    end

    local function show()
        button.show()
    end

    local function hide()
        button.hide()
    end

    local function inc()
        count = count + 1

        button.updateTitle(count)
    end

    local function dec()
        count = count - 1

        button.updateTitle(count)
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
