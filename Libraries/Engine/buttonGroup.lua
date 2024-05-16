local Button = require "Libraries.Engine.button"
local Pool = require "Libraries.Engine.pool"

---@param buttons table
local ButtonGroup = function(buttons)
    ---@type any[]
    local buttonGroup = {}

    local pool = Pool(buttonGroup)

    local function destroy()
        pool.destroy()
    end

    ---@param group table
    local function create(group)
        for i = 1, #buttons, 1 do
            local label = buttons[i].label
            local action = buttons[i].action

            local button = Button(label, action)

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

    ---@class ButtonGrount
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
