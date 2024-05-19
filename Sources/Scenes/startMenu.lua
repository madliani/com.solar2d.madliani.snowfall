local Resources = require "resources"

local Background = require "Libraries.Engine.Widgets.background"
local Scene = require "Libraries.Engine.Core.scene"

local Snowfall = require "Sources.snowfall"

local Heading = require "Sources.Objects.heading"
local Menu = require "Sources.Objects.menu"

local heading = Heading("Snowfall")
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
