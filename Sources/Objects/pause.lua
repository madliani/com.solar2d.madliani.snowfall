local Coordinate = require "Libraries.Engine.Core.coordinate"
local Event = require "Libraries.Engine.Core.event"
local Image = require "Libraries.Engine.Core.image"
local Resources = require "resources"
local ScenePaths = require "Sources.scenePaths"
local Size = require "Libraries.Engine.Core.size"
local Snowfall = require "Sources.snowfall"
local display = require "display"

local coordinate = Coordinate(50, display.contentHeight + 25)
local size = Size(25, 25)
local path = Resources.Images.transparrentPause

local event = Event(function()
    Snowfall.pause(ScenePaths.pauseMenu)
end, "tap")

local Pause = function()
    ---@class Pause
    return Image(path, size, coordinate, event)
end

return Pause
