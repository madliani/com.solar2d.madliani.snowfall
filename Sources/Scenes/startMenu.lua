local Background = require "Libraries.Engine.Widgets.background"
local Heading = require "Sources.Objects.heading"
local Menu = require "Sources.Objects.menu"
local Resources = require "resources"
local Scene = require "Libraries.Engine.Core.scene"
local ScenePaths = require "Sources.scenePaths"
local Snowfall = require "Sources.snowfall"

local background = Background(Resources.Images.background)
local heading = Heading "Snowfall"

local menu = Menu {
    {
        text = "Start Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.start(ScenePaths.startMenu, ScenePaths.world)
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
                Snowfall.exit(ScenePaths)
            end,
        },
    },
}

return Scene {
    background,
    heading,
    menu,
}
