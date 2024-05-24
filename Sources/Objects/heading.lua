local display = require "display"

local Resources = require "resources"

local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Label = require "Libraries.Engine.Widgets.label"
local Title = require "Libraries.Engine.Core.title"

local architectsDaughter = Font(Resources.Fonts.architectsDaughter)
local color = Color(0, 0, 0)
local coordinate = Coordinate(display.contentCenterX, display.contentCenterY - 200)
local size = 48

---@param heading string
local Heading = function(heading)
    local title = Title(heading, architectsDaughter, color, size)

    ---@class Heading
    return Label(title, coordinate)
end

return Heading
