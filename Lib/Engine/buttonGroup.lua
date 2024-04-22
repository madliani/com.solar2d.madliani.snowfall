local Pool = require("Lib.Engine.pool")

---@param buttons table
local ButtonGroup = function (buttons)
    local buttonGroup = Pool(buttons)

    local function destroy()
        buttonGroup.destroy()
    end

    ---@param group table
    local function create(group)
        buttonGroup.create(group)
    end

    local function show()
        buttonGroup.show()
    end

    local function hide()
        buttonGroup.hide()
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
