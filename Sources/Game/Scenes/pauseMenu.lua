local Background = require "Libraries.Engine.Nodes.background"
local Heading = require "Sources.Game.Nodes.heading"
local Menu = require "Sources.Game.Nodes.menu"
local Paths = require "Sources.Game.paths"
local Resources = require "Sources.Game.resources"
local Scene = require "Libraries.Engine.Core.scene"
local Snowfall = require "Sources.Game.snowfall"

local background = Background(Resources.Images.background)
local heading = Heading "Snowfall"

local menu = Menu {
    {
        text = "Resume Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.resume(Paths.Scenes.pauseMenu, Paths.Scenes.world)
            end,
        },
    },
    {
        text = "Restart Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.restart(Paths.Scenes.pauseMenu, Paths.Scenes.world)
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
