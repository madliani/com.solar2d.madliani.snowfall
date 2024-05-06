---@param x integer
---@param y integer
local Coordinate = function (x, y)
	---@class Coordinate
	---@field x integer
	---@field y integer
	return {
		x = x,
		y = y
	}
end

return Coordinate
