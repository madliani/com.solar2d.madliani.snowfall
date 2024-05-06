---@param objects table
local Pool = function(objects)
    local pool = objects

    local function destroy()
        if pool ~= nil and #pool > 0 then
            for i = 1, #pool, 1 do
                pool[i].destroy()
            end
        end
    end

    ---@param group table
    local function create(group)
        if pool ~= nil and #pool > 0 then
            for i = 1, #pool, 1 do
                if group ~= nil then
                    pool[i].create(group)
                else
                    pool[i].create()
                end
            end
        end
    end

    local function show()
        if pool ~= nil and #pool > 0 then
            for i = 1, #pool, 1 do
                local object = pool[i]

                if object.show ~= nil then
                    object.show()
                elseif object.unmute ~= nil then
                    object.unmute()
                end
            end
        end
    end

    local function hide()
        if pool ~= nil and #pool > 0 then
            for i = 1, #pool, 1 do
                local object = pool[i]

                if object.hide ~= nil then
                    object.hide()
                elseif object.mute ~= nil then
                    object.mute()
                end
            end
        end
    end

    ---@class Pool
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

return Pool
