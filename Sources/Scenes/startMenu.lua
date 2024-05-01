local Resources = require("resources")

local Scene = require("Libraries.Engine.scene")
local Background = require("Libraries.Engine.background")
local Game = require("Libraries.Engine.game")

local ItemGroup = require("Sources.Objects.itemGroup")

local background = Background(Resources.Images.background)
local game = Game()

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
                        game.resume()
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
                        game.destroy()
                    end
                }
            }
        }
    }
}
