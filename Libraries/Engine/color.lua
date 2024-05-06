---@param red integer
---@param green integer
---@param blue integer
local Color = function (red, green, blue)
	---@class Color
	---@field red integer
	---@field green integer
	---@field blue integer
	return {
		red = red,
		green = green,
		blue = blue
	}
end

return Color
