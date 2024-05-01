local composer = require("composer")
local os = require("os")

local Resources = require("resources")

local Scene = require("Lib.Engine.scene")
local Background = require("Lib.Engine.background")

local ItemGroup = require("Objects.itemGroup")

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
                        composer.removeScene("Scenes.startMenu")
                        composer.gotoScene("Scenes.game")
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
