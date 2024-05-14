local Resources = require "resources"

local Background = require "Libraries.Engine.background"
local Scene = require "Libraries.Engine.scene"

local Snowfall = require "Sources.snowfall"

local MenuBackground = require "Sources.Objects.menuBackground"
local ItemGroup = require "Sources.Objects.itemGroup"

local background = Background(Resources.Images.background)

local menuBackground = MenuBackground()

local itemGroup = ItemGroup {
    {
        title = "Start Game",
        action = {
            type = "tap",
            method = function()
                Snowfall.start()
            end,
        },
    },
    {
        title = "About Game",
        action = {
            type = "tap",
            method = function() end,
        },
    },
    {
        title = "Exit",
        action = {
            type = "tap",
            method = function()
                Snowfall.exit()
            end,
        },
    },
}

return Scene {
    background,
    menuBackground,
    itemGroup,
}
