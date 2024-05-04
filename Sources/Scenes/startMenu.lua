local Resources = require("resources")

local Scene = require("Libraries.Engine.scene")
local Background = require("Libraries.Engine.background")

local Snowfall = require("Sources.snowfall")

local ItemGroup = require("Sources.Objects.itemGroup")

local background = Background(Resources.Images.background)

local itemGroup = ItemGroup {
    {
        title = "Start Game",
        action =
        {
            type = "tap",
            method = function ()
                Snowfall.start()
            end
        }
    },
    {
        title = "About Game",
        action =
        {
            type = "tap",
            method = function () end
        }
    },
    {
        title = "Exit",
        action =
        {
            type = "tap",
            method = function ()
                Snowfall.exit()
            end
        }
    }
}

return Scene {
    background,
    itemGroup
}
