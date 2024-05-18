local Resources = require "resources"

local Background = require "Libraries.Engine.background"
local Scene = require "Libraries.Engine.scene"

local Snowfall = require "Sources.snowfall"

local ItemGroup = require "Sources.Objects.itemGroup"

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
    itemGroup,
}
