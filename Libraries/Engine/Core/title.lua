---@class Title
---@field text string
---@field font Font
---@field color Color
---@field size integer

---@alias TitleClass fun(title: Title): Title
---@alias TitleIdentificator string

---@class TitlePrototype
---@field id TitleIdentificator
---@field maker fun(title: Title): Title

---@alias TitleContainer fun(prototype: TitlePrototype): TitleClass

---@type TitleContainer
local Container = require "Libraries.Prelude.container"

local Title = Container {
    id = "title",

    maker = function(title)
        return title
    end,
}

return Title
