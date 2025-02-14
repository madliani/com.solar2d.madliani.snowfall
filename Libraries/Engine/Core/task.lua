---@class Task
---@field action fun()
---@field time integer

---@alias TaskClass fun(task: Task): Task
---@alias TaskIdentificator string

---@class TaskPrototype
---@field id TaskIdentificator
---@field maker fun(task: Task): Task

---@alias TaskContainer fun(prototype: TaskPrototype): TaskClass

---@type TaskContainer
local Container = require "Libraries.Prelude.container"

local Task = Container {
    id = "task",

    maker = function(task)
        return task
    end,
}

return Task
