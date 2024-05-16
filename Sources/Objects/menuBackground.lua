local display = require "display"

local Resources = require "resources"

local Pool = require "Libraries.Engine.pool"
local Image = require "Libraries.Engine.image"
local Size = require "Libraries.Engine.size"
local Coordinate = require "Libraries.Engine.coordinate"

local itemsCount = 5
local size = Size(190, 24)

local MenuBackground = function()
    ---@type any[]
    local dropdown = {}

    for i = 1, itemsCount, 1 do
        local coordinate = Coordinate(display.contentCenterX, display.contentCenterY - i * size.height)
        local dropdownMiddle = Image(Resources.Images.dropdownMiddle, size, coordinate)

        table.insert(dropdown, dropdownMiddle)
    end

    for i = 1, itemsCount, 1 do
        local coordinate = Coordinate(display.contentCenterX, display.contentCenterY + i * size.height)
        local dropdownMiddle = Image(Resources.Images.dropdownMiddle, size, coordinate)

        table.insert(dropdown, dropdownMiddle)
    end

    local coordinateTop = Coordinate(display.contentCenterX, display.contentCenterY - (itemsCount + 1) * size.height)
    local coordinateMiddle = Coordinate(display.contentCenterX, display.contentCenterY)
    local coordinateBottom = Coordinate(display.contentCenterX, display.contentCenterY + (itemsCount + 1) * size.height)

    local dropdownTop = Image(Resources.Images.dropdownTop, size, coordinateTop)
    local dropdownMiddle = Image(Resources.Images.dropdownMiddle, size, coordinateMiddle)
    local dropdownBottom = Image(Resources.Images.dropdownBottom, size, coordinateBottom)

    table.insert(dropdown, dropdownTop)
    table.insert(dropdown, dropdownMiddle)
    table.insert(dropdown, dropdownBottom)

    local pool = Pool(dropdown)

    local function destroy()
        pool.destroy()
    end

    ---@param group table
    local function create(group)
        pool.create(group)
    end

    local function show()
        pool.show()
    end

    local function hide()
        pool.hide()
    end

    ---@class Menu
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

return MenuBackground
