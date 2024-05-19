local display = require "display"

local Resources = require "resources"

local Background = require "Libraries.Engine.Widgets.background"
local Color = require "Libraries.Engine.Core.color"
local Coordinate = require "Libraries.Engine.Core.coordinate"
local Font = require "Libraries.Engine.Core.font"
local Label = require "Libraries.Engine.Widgets.label"
local Scene = require "Libraries.Engine.Core.scene"
local Title = require "Libraries.Engine.Core.title"

local Snowfall = require "Sources.snowfall"

local Menu = require "Sources.Objects.menu"

local architectsDaughter = Font(Resources.Fonts.architectsDaughter)
local color = Color(0, 0, 0)
local size = 48
local title = Title("Snowfall", architectsDaughter, color, size)
local coordinate = Coordinate(display.contentCenterX, display.contentCenterY - 200)
local heading = Label(title, coordinate)
local background = Background(Resources.Images.background)

local menu = Menu {
    {
        text = "Start Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.start()
            end,
        },
    },
    {
        text = "About Game",
        event = {
            type = "tap",
            action = function() end,
        },
    },
    {
        text = "Exit",
        event = {
            type = "tap",
            action = function()
                Snowfall.exit()
            end,
        },
    },
}

return Scene {
    background,
    heading,
    menu,
}
