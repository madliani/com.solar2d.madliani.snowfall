local timer = require("timer")

local Resources = require("resources")

local Snowflake = require("Sources.Objects.snowflake")

---@param counter Counter
local Blizzard = function(counter)
	---@type table | nil
	local snowflakes = {}

	---@type table | nil
	local sceneGroup = nil

	local function generateSnowflakes()
		if snowflakes ~= nil and sceneGroup ~= nil then
			local snowflake = Snowflake(Resources.Images.snowflake, counter)

			snowflake.create(sceneGroup)
			table.insert(snowflakes, snowflake)

			timer.performWithDelay(500, generateSnowflakes)
		end
	end

	local function update()
		if snowflakes ~= nil and #snowflakes > 0 then
			for i = #snowflakes, 1, -1 do
				local snowflake = snowflakes[i]

				if snowflake.isUnavable() then
					snowflake.destroy()
				else
					snowflake.update()
				end
			end
		end
	end

	local function destroy()
		if snowflakes ~= nil and #snowflakes > 0 and sceneGroup ~= nil then
			for i = 1, #snowflakes, 1 do
				local snowflake = snowflakes[i]

				snowflake.destroy()
			end

			snowflakes = nil
			sceneGroup = nil
		end
	end

	---@param group table
	local function create(group)
		sceneGroup = group

		generateSnowflakes()

		Runtime.addEventListener(Runtime, "enterFrame", update)
	end

	local function show()
		if snowflakes ~= nil and #snowflakes > 0 then
			for i = 1, #snowflakes, 1 do
				snowflakes[i].show()
			end
		end
	end

	local function hide()
		if snowflakes ~= nil and #snowflakes > 0 then
			for i = 1, #snowflakes, 1 do
				snowflakes[i].hide()
			end
		end
	end

	---@class Blizzard
	---@field create function
	---@field destroy function
	---@field hide function
	---@field show function
	return {
		create = create,
		destroy = destroy,
		hide = hide,
		show = show,
	}
end

return Blizzard
