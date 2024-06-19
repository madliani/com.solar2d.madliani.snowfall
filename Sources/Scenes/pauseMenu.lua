local Background = require "Libraries.Engine.Widgets.background"
local Heading = require "Sources.Objects.heading"
local Menu = require "Sources.Objects.menu"
local Resources = require "resources"
local Scene = require "Libraries.Engine.Core.scene"
local Snowfall = require "Sources.snowfall"

local background = Background(Resources.Images.background)
local heading = Heading "Snowfall"

local menu = Menu {
    {
        text = "Resume Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.resume()
            end,
        },
    },
    {
        text = "Restart Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.restart()
            end,
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
