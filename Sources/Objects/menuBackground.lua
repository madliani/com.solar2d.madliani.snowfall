local display = require "display"

local Resources = require "resources"

local Pool = require "Libraries.Engine.pool"
local Image = require "Libraries.Engine.image"

local itemsCount = 5
local width = 190
local height = 24
local coordinateX = display.contentCenterX
local coordinateY = display.contentCenterY

local MenuBackground = function()
    ---@type any[]
    local dropdown = {}

    for i = 1, itemsCount, 1 do
        local dropdownMiddle =
            Image(Resources.Images.dropdownMiddle, width, height, coordinateX, coordinateY - i * height)

        table.insert(dropdown, dropdownMiddle)
    end

    for i = 1, itemsCount, 1 do
        local dropdownMiddle =
            Image(Resources.Images.dropdownMiddle, width, height, coordinateX, coordinateY + i * height)

        table.insert(dropdown, dropdownMiddle)
    end

    local dropdownTop =
        Image(Resources.Images.dropdownTop, width, height, coordinateX, coordinateY - (itemsCount + 1) * height)
    local dropdownMiddle = Image(Resources.Images.dropdownMiddle, width, height, coordinateX, coordinateY)
    local dropdownBottom =
        Image(Resources.Images.dropdownBottom, width, height, coordinateX, coordinateY + (itemsCount + 1) * height)

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
