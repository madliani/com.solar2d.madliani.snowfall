local Background = require "Libraries.Engine.Widgets.background"
local Heading = require "Sources.Widgets.heading"
local Menu = require "Sources.Widgets.menu"
local Resources = require "resources"
local Scene = require "Libraries.Engine.Core.scene"
local Snowfall = require "Sources.snowfall"
local paths = require "paths"

local background = Background(Resources.Images.background)
local heading = Heading "Snowfall"

local menu = Menu {
    {
        text = "Start Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.start(paths.Scenes.startMenu, paths.Scenes.world)
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
