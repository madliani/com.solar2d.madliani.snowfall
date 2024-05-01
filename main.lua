local composer = require("composer")

local Resources = require("resources")

local Sound = require("Lib.Engine.sound")

local sound = Sound(Resources.Sounds.background)

sound.create()

composer.gotoScene("Scenes.startMenu")
