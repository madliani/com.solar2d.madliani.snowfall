local display = require "display"

local Image = require "Libraries.Engine.image"

---@param path string
local Background = function(path)
    local width = display.pixelWidth
    local height = display.pixelHeight
    local coordinateX = display.contentCenterX
    local coordinateY = display.contentCenterY

    local image = Image(path, width, height, coordinateX, coordinateY)

    local function destroy()
        image.destroy()
    end

    ---@param group table
    local function create(group)
        image.create(group)
    end

    local function show()
        image.show()
    end

    local function hide()
        image.hide()
    end

    ---@class Background
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

return Background
