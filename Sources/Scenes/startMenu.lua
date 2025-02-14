local Background = require "Libraries.Engine.Nodes.background"
local Heading = require "Sources.Nodes.heading"
local Menu = require "Sources.Nodes.menu"
local Resources = require "resources"
local Scene = require "Libraries.Engine.Core.scene"
local Snowfall = require "Sources.snowfall"
local Paths = require "Sources.paths"

local background = Background(Resources.Images.background)
local heading = Heading "Snowfall"

local menu = Menu {
    {
        text = "Start Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.start(Paths.Scenes.startMenu, Paths.Scenes.world)
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
