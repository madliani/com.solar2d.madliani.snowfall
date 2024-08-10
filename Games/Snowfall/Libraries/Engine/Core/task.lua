---@class Task
---@field action fun()
---@field time integer

---@alias TaskClass fun(action: fun(), time: integer): Task
---@alias TaskIdentificator string

---@class TaskPrototype
---@field id TaskIdentificator
---@field maker fun(action: fun(), time: integer): Task

---@alias TaskContainer fun(prototype: TaskPrototype): TaskClass

---@type TaskContainer
local Container = require "Libraries.Prelude.container"

local Task = Container {
    id = "task",

    maker = function(action, time)
        return {
            action = action,
            time = time,
        }
    end,
}

return Task
