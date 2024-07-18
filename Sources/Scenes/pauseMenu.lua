local Background = require "Libraries.Engine.Nodes.background"
local Heading = require "Sources.Nodes.heading"
local Menu = require "Sources.Nodes.menu"
local Resources = require "resources"
local Scene = require "Libraries.Engine.Core.scene"
local Snowfall = require "Sources.snowfall"
local paths = require "paths"

local background = Background(Resources.Images.background)
local heading = Heading "Snowfall"

local menu = Menu {
    {
        text = "Resume Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.resume(paths.Scenes.pauseMenu, paths.Scenes.world)
            end,
        },
    },
    {
        text = "Restart Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.restart(paths.Scenes.pauseMenu, paths.Scenes.world)
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
