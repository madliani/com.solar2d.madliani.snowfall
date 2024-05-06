---@param type string
---@param method function
local Action = function (type, method)
	---@class Action
	---@field type string
	---@field method function
	return {
		type = type,
		method = method
	}
end

return Action
