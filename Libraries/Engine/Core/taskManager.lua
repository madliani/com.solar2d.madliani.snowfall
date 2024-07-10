local _ = require "Libraries.Prelude.enumerable"
local timer = require "timer"

---@alias TaskIdentificator string

---@class TaskManager
---@field add fun(task: Task, id: TaskIdentificator)
---@field addInfinite fun(task: Task, id: TaskIdentificator)
---@field pause fun(id: TaskIdentificator)
---@field pauseAll fun()
---@field remove fun(id: TaskIdentificator)
---@field removeAll fun()
---@field resume fun(id: TaskIdentificator)
---@field resumeAll fun()

---@alias TaskManagerClass fun(): TaskManager
---@alias TaskManagerIdentificator string

---@class TaskManagerSelf: TaskManagerAttributes, TaskManagerMethods

---@class TaskManagerAttributes
---@field tasks Task[] | nil

---@class TaskManagerMethods
---@field add fun(self: TaskManagerSelf, task: Task, id: TaskIdentificator)
---@field addInfinite fun(self: TaskManagerSelf, task: Task, id: TaskIdentificator)
---@field pause fun(self: TaskManagerSelf, id: TaskIdentificator)
---@field pauseAll fun()
---@field remove fun(self: TaskManagerSelf, id: TaskIdentificator)
---@field removeAll fun(self: TaskManagerSelf)
---@field resume fun(self: TaskManagerSelf, id: TaskIdentificator)
---@field resumeAll fun()

---@class TaskManagerPrototype
---@field id TaskManagerIdentificator
---@field attributes TaskManagerAttributes
---@field methods TaskManagerMethods

---@alias TaskManagerSingleton fun(prototype: TaskManagerPrototype): TaskManagerClass

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

        pause = function(self, id)
            local task = self.tasks[id]

            timer.pause(task)
        end,

        pauseAll = function()
            timer.pauseAll()
        end,

        remove = function(self, id)
            local task = self.tasks[id]

            timer.cancel(task)

            self.tasks[id] = nil
        end,

        removeAll = function(self)
            timer.cancelAll()

            self.tasks = _.map(self.tasks, function()
                return nil
            end)
        end,

        resume = function(self, id)
            local task = self.tasks[id]

            timer.resume(task)
        end,

        resumeAll = function()
            timer.resumeAll()
        end,
    },
}

return TaskManager
