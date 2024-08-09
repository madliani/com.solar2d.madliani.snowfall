local native = require "native"

---@class Font

---@alias FontName string
---@alias FontClass fun(fontName: FontName): Font
---@alias FontIdentificator string

---@class FontPrototype
---@field id FontIdentificator
---@field wrapper fun(fontName: FontName): Font

---@alias FontAdapter fun(prototype: FontPrototype): FontClass

---@type FontAdapter
local Adapter = require "Libraries.Prelude.adapter"

local Font = Adapter {
    id = "font",

    wrapper = function(fontName)
        if fontName == "system" then
            return native.systemFont
        else
            return native.newFont(fontName)
        end
    end,
}

return Font
