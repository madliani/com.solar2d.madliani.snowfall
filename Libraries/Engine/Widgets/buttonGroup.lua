local Button = require "Libraries.Engine.Widgets.button"
local Pool = require "Libraries.Engine.Core.pool"

---@param buttons table<any>[]
local ButtonGroup = function(buttons)
    ---@type unknown[]
    local buttonGroup = {}

    local pool = Pool(buttonGroup)

    local function destroy()
        pool.destroy()
    end

    ---@param group table
    local function create(group)
        for i = 1, #buttons, 1 do
            local path = buttons[i].path
            local title = buttons[i].title
            local size = buttons[i].size
            local coordinate = buttons[i].coordinate
            local event = buttons[i].event

            local button = Button(path, title, size, coordinate, event)

            table.insert(buttonGroup, button)
        end

        pool.create(group)
    end

    local function show()
        pool.show()
    end

    local function hide()
        pool.hide()
    end

    ---@class ButtonGroup
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

return ButtonGroup
