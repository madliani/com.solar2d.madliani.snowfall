local Pool = function ()
    local objects = {}

    ---@param object table
    local function insert(object)
        if objects ~= nil then
            table.insert(objects, object)
        end
    end

    local function destroy()
        if objects ~= nil and #objects > 0 then
            for i = 1, #objects, 1 do
                objects[i].destroy()

                table.remove(objects, i)
            end
        end
    end

    ---@param group table
    local function create(group)
        if objects ~= nil and #objects > 0 then
            for i = 1, #objects, 1 do
                objects[i].create(group)
            end
        end
    end

    local function show()
        if objects ~= nil and #objects > 0 then
            for i = 1, #objects, 1 do
                local object = objects[i]

                if object.show ~= nil then
                    object.show()
                elseif object.unmute ~= nil then
                    object.unmute()
                end
            end
        end
    end

    local function hide()
        if objects ~= nil and #objects > 0 then
            for i = 1, #objects, 1 do
                local object = objects[i]

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
    ---@field insert function
    ---@field show function
    return {
        create = create,
        destroy = destroy,
        hide = hide,
        insert = insert,
        show = show
    }
end

return Pool
