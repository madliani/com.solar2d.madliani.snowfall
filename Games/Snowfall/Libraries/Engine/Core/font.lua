local native = require "native"

---@class Font

---@alias FontPath string
---@alias FontClass fun(path: FontPath): Font
---@alias FontIdentificator string

---@class FontPrototype
---@field id FontIdentificator
---@field wrapper fun(path: FontPath): Font

---@alias FontAdapter fun(prototype: FontPrototype): FontClass

---@type FontAdapter
local Adapter = require "Libraries.Prelude.adapter"

local Font = Adapter {
    id = "font",

    wrapper = function(path)
        if path == "system" then
            return native.systemFont
        else
            return native.newFont(path)
        end
    end,
}

return Font
