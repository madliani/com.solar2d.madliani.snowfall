local composer = require("composer")
local os = require("os")

local Scene = require("Lib.Engine.scene")
local Background = require("Lib.Engine.background")
local Sound = require("Lib.Engine.sound")

local ItemGroup = require("Objects.itemGroup")

local background = Background("Assets/background.png")
local sound = Sound("Sounds/the_field_of_dreams.mp3")

return Scene {
    background = background,
    sound = sound,
    objects =
    {
        ItemGroup {
            {
                title = "Start Game",
                action =
                {
                    type = "tap",
                    method = function ()
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
