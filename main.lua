local composer = require("composer")

local Resources = require("resources")

local Sound = require("Libraries.Engine.sound")

local sound = Sound()

sound.create(Resources.Sounds.background)

composer.gotoScene("Sources.Scenes.startMenu")
