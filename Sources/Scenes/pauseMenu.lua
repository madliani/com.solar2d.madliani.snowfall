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
        text = "Resume Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.resume(ScenePaths.pauseMenu, ScenePaths.world)
            end,
        },
    },
    {
        text = "Restart Game",
        event = {
            type = "tap",
            action = function()
                Snowfall.restart(ScenePaths.pauseMenu, ScenePaths.world)
            end,
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
