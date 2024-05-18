local display = require "display"

local Coordinate = require "Libraries.Engine.coordinate"
local Image = require "Libraries.Engine.image"
local Size = require "Libraries.Engine.size"

local size = Size(display.pixelWidth, display.pixelHeight)
local coordinate = Coordinate(display.contentCenterX, display.contentCenterY)

---@param path string
local Background = function(path)
    local image = Image(path, size, coordinate)

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
