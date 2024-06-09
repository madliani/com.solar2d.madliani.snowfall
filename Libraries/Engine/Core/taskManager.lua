local timer = require "timer"

---@alias TaskIdentificator string

---@class TaskManager
---@field add fun(task: Task, id: TaskIdentificator)
---@field addInfinite fun(task: Task, id: TaskIdentificator)
---@field remove fun(id: TaskIdentificator)
---@field pause fun(id: TaskIdentificator)
---@field resume fun(id: TaskIdentificator)

---@alias TaskManagerClass fun(): TaskManager
---@alias TaskManagerIdentificator string

---@class TaskManagerAttributes
---@field tasks Task[] | nil

---@class TaskManagerSelf: TaskManagerMethods
---@field tasks Task[]

---@class TaskManagerMethods
---@field add fun(self: TaskManagerSelf, task: Task, id: TaskIdentificator)
---@field addInfinite fun(self: TaskManagerSelf, task: Task, id: TaskIdentificator)
---@field remove fun(self: TaskManagerSelf, id: TaskIdentificator)
---@field pause fun(self: TaskManagerSelf, id: TaskIdentificator)
---@field resume fun(self: TaskManagerSelf, id: TaskIdentificator)

---@class TaskManagerMetaclass
---@field id TaskManagerIdentificator
---@field attributes TaskManagerAttributes
---@field methods TaskManagerMethods

---@alias TaskManagerSingleton fun(metaclass: TaskManagerMetaclass): TaskManagerClass

---@type TaskManagerSingleton
local Singleton = require "Libraries.Prelude.singleton"

local TaskManager = Singleton {
    id = "task_manger",

    attributes = {
        tasks = {},
    },

    methods = {
        add = function(self, task, id)
            self.tasks[id] = timer.performWithDelay(task.time, task.action)
        end,

        addInfinite = function(self, task, id)
            self.tasks[id] = timer.performWithDelay(task.time, task.action, 0)
        end,

        remove = function(self, id)
            local task = self.tasks[id]

            timer.cancel(task)

            self.tasks[id] = nil
        end,

        pause = function(self, id)
            local task = self.tasks[id]

            timer.pause(task)
        end,

        resume = function(self, id)
            local task = self.tasks[id]

            timer.resume(task)
        end,
    },
}

return TaskManager
