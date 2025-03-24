---@class ScoreCounter
---@field inc fun()
---@field dec fun()

---@alias ScoreCounterClass fun(score: Score): ScoreCounter
---@alias ScoreCounterIdentificator string

---@class ScoreCounterAttributes
---@field score Score | nil

---@class ScoreCounterSelf: ScoreCounterAttributes, ScoreCounterMethods

---@class ScoreCounterMethods
---@field inc fun(self: ScoreCounterSelf)
---@field dec fun(self: ScoreCounterSelf)

---@alias ScoreCounterInitializer fun(attributes: ScoreCounterAttributes, score: Score)
---@alias ScoreCounterFinalizer fun(attributes: ScoreCounterAttributes)

---@class ScoreCounterPrototype
---@field id ScoreCounterIdentificator
---@field attributes ScoreCounterAttributes
---@field methods ScoreCounterMethods
---@field initializer ScoreCounterInitializer?
---@field finalizer ScoreCounterFinalizer?

---@alias ScoreCounterMetaclass fun(prototype: ScoreCounterPrototype): ScoreCounterClass

---@type ScoreCounterMetaclass
local Metaclass = require "Libraries.Prelude.metaclass"

local ScoreCounter = Metaclass {
    id = "score_counter",

    attributes = {
        score = nil,
    },

    methods = {
        inc = function(self)
            if self.score ~= nil then
                self.score.inc()
            end
        end,

        dec = function(self)
            if self.score ~= nil then
                self.score.dec()
            end
        end,
    },

    initializer = function(attributes, score)
        attributes.score = score
    end,
}

return ScoreCounter
