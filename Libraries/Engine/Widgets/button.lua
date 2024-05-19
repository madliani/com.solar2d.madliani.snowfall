local Image = require "Libraries.Engine.Core.image"
local Label = require "Libraries.Engine.Widgets.label"

---@param path string
---@param title Title
---@param size Size
---@param coordinate Coordinate
---@param event Event
local Button = function(path, title, size, coordinate, event)
    ---@type Image | nil
    local image = Image(path, size, coordinate, event)

    ---@type Label | nil
    local label = Label(title, coordinate)

    ---@type table | nil
    local sceneGroup = nil

    local function destroy()
        if image ~= nil and label ~= nil and sceneGroup ~= nil then
            image.destroy()
            label.destroy()

            image = nil
            label = nil
            sceneGroup = nil
        end
    end

    ---@param group table
    local function create(group)
        sceneGroup = group

        if image ~= nil and label ~= nil then
            image.create(group)
            label.create(group)
        end
    end

    local function show()
        if image ~= nil and label ~= nil then
            image.show()
            label.show()
        end
    end

    local function hide()
        if image ~= nil and label ~= nil then
            image.hide()
            label.hide()
        end
    end

    ---@class Button
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

return Button
