local Pool = function ()
    local pool = {}

    ---@param objects table
    local function insert(objects)
        if pool ~= nil and #pool == 0 then
            pool = objects
        end
    end

    local function destroy()
        if pool ~= nil and #pool > 0 then
            for i = 1, #pool, 1 do
                pool[i].destroy()

                table.remove(pool, i)
            end
        end
    end

    ---@param group table
    local function create(group)
        if pool ~= nil and #pool > 0 then
            for i = 1, #pool, 1 do
                pool[i].create(group)
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
