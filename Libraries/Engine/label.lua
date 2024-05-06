---@param title string
---@param coordinate Coordinate
---@param font Font
---@param color Color
local Label = function (title, coordinate, font, color)
	---@class Label
	---@field title string
	---@field coordinate Coordinate
	---@field font Font
	---@field color Color
	return {
		title = title,
		coordinate = coordinate,
		font = font,
		color = color
	}
end

return Label
