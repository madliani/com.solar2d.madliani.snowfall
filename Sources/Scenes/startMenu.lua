local composer = require("composer")
local os = require("os")

local Resources = require("resources")

local Scene = require("Libraries.Engine.scene")
local Background = require("Libraries.Engine.background")

local ItemGroup = require("Sources.Objects.itemGroup")

local background = Background(Resources.Images.background)

return Scene {
    background = background,
    objects =
    {
        ItemGroup {
            {
                title = "Start Game",
                action =
                {
                    type = "tap",
                    method = function ()
                        composer.removeScene("Sources.Scenes.startMenu")
                        composer.gotoScene("Sources.Scenes.game")
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
                        os.exit()
                    end
                }
            }
        }
    }
}
