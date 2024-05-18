local display = require "display"

local Resources = require "resources"

local Background = require "Libraries.Engine.background"
local Color = require "Libraries.Engine.color"
local Coordinate = require "Libraries.Engine.coordinate"
local Font = require "Libraries.Engine.font"
local Label = require "Libraries.Engine.label"
local Scene = require "Libraries.Engine.scene"
local Title = require "Libraries.Engine.title"

local Snowfall = require "Sources.snowfall"

local ItemGroup = require "Sources.Objects.itemGroup"

local architectsDaughter = Font(Resources.Fonts.architectsDaughter)
local color = Color(0, 0, 0)
local size = 48
local title = Title("Snowfall", architectsDaughter, color, size)
local coordinate = Coordinate(display.contentCenterX, display.contentCenterY - 200)
local heading = Label(title, coordinate)
local background = Background(Resources.Images.background)

local itemGroup = ItemGroup {
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
    itemGroup,
}
