local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Label = require "Libraries.Engine.Nodes.label"
local Resources = require "resources"
local Title = require "Libraries.Engine.Core.title"
local display = require "display"

local architectsDaughter = Font(Resources.Fonts.main)
local color = Color(1, 1, 1)
local coordinate = Coordinate(display.contentCenterX, display.contentCenterY - 200)
local size = 48

---@param text string
local Heading = function(text)
    local title = Title(text, architectsDaughter, color, size)

    ---@class Heading
    return Label(title, coordinate)
end

return Heading
