local Button = require("Objects.button")

---@param buttons integer
local ButtonGroup = function (buttons)
    local buttonGroup = {}

    for i = 1, #buttons, 1 do
        local button = buttons[i]

        table.insert(buttonGroup, Button(button.label, button.action))
    end

    local function destroy()
        if buttonGroup ~= nil and #buttonGroup > 0 then
            for i = 1, #buttons, 1 do
                buttonGroup[i].destroy()
            end
        end
    end

    ---@param group table
    local function create(group)
        if buttonGroup ~= nil and #buttonGroup > 0 then
            for i = 1, #buttons, 1 do
                buttonGroup[i].create(group)
            end
        end
    end

    local function show()
        if buttonGroup ~= nil and #buttonGroup > 0 then
            for i = 1, #buttons, 1 do
                buttonGroup[i].show()
            end
        end
    end

    local function hide()
        if buttonGroup ~= nil and #buttonGroup > 0 then
            for i = 1, #buttons, 1 do
                buttonGroup[i].hide()
            end
        end
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
        show = show
    }
end

return ButtonGroup
